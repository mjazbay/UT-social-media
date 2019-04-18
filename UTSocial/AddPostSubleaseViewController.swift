//
//  AddPostSubleaseViewController.swift
//  UTSocial
//
//  Created by Maksat Zhazbayev on 4/15/19.
//  Copyright © 2019 Maksat Zhazbayev. All rights reserved.
//

import UIKit
import Parse
import AlamofireImage

class AddPostSubleaseViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate, UITextFieldDelegate {
    
    //constant labels
    @IBOutlet weak var defaultPicture: UIImageView!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    var anythingEmpty = false
    
    //Tap Camera Gesture to Open Camera or Gallery Library
    @IBAction func cameraTapGesture(_ sender: UITapGestureRecognizer)
    {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera)
        {
            picker.sourceType = .camera
        }
        else
        {
            picker.sourceType = .photoLibrary
        }
        present(picker, animated: true, completion: nil)
    }
    
    //selecting and saving the image to variable and updating default picture image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        let size = CGSize(width: 394, height: 245)
        let scaledImage = image.af_imageAspectScaled(toFill: size)
        
        self.defaultPicture.image = scaledImage
        dismiss(animated: true, completion: nil)
    }
    //sending all the data to parse server
    @IBAction func postButton(_ sender: Any)
    {
        self.emptyTextFields()
        
        if !anythingEmpty {
            //initializing parse class for sublease
            let Sublease = PFObject(className: "Sublease")
            Sublease["Address"] = addressTextField.text
            Sublease["Price"] = priceTextField.text
            Sublease["Description"] = descriptionTextView.text
            //Sublease["author"] = PFUser.current()
            
            //converting image into png data and save it
            let imageData = defaultPicture.image!.pngData()!
            let file = PFFileObject(data: imageData)
            
            Sublease["PosterPic"] = file
            
            Sublease.saveInBackground { (success, error) in
                if success
                {
                    print("Saved")
                    self.defaultTextFormat()
                }
                else
                {
                    print("Error Saving:  \(error?.localizedDescription)")
                }
            }
        }
    }
    
    //cancel Button dismisses Posting Page, goes back to list of subleases
    @IBAction func cancelButton(_ sender: Any)
    {
     dismiss(animated: true, completion: nil)
    }
    
    
    //Description gets cleared upon editing it.
    func textViewDidBeginEditing(_ textView: UITextView) {
        if descriptionTextView.textColor == UIColor.lightGray
        {
            descriptionTextView.textColor = UIColor.black
            descriptionTextView.text = String()
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if descriptionTextView.text.isEmpty
        {
            descriptionTextView.textColor = UIColor.lightGray
            descriptionTextView.text = "Hi there, I am subleasing my place for Fall 2019"
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if (textField == priceTextField) || (textField == addressTextField ) {
            textField.text = String()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.descriptionTextView.delegate = self
        self.priceTextField.delegate = self
        self.addressTextField.delegate = self

        defaultTextFormat()
        // Do any additional setup after loading the view.
    }
    
    //checks text fields for emptyness, and if so changes values of global variale anythinEmpty = true
    func emptyTextFields()
    {
        if addressTextField.text!.isEmpty
        {
            addressTextField.backgroundColor = UIColor.red
            self.anythingEmpty = true
        }
        else if priceTextField.text!.isEmpty
        {
            priceTextField.backgroundColor = UIColor.red
            self.anythingEmpty = true
        }
        else if descriptionTextView.text!.isEmpty
        {
            descriptionTextView.backgroundColor = UIColor.red
            self.anythingEmpty = true
        }
        reloadInputViews()
    }
    
    //Original looks of text fields
    func defaultTextFormat()
    {
        //Description Format
        descriptionTextView.textColor = UIColor.lightGray
        descriptionTextView.text = "Hi there, I am subleasing my place for Fall 2019"
        self.descriptionTextView.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).cgColor
        self.descriptionTextView.layer.borderWidth = 1.0
        self.descriptionTextView.layer.cornerRadius = 5
    
        //Price Format
        self.priceTextField.keyboardType = .numbersAndPunctuation
        self.priceTextField.placeholder = "$1000"
        
        
        //Address Format
        self.addressTextField.placeholder = "600 W 26th Street, 78705"
    }
}
