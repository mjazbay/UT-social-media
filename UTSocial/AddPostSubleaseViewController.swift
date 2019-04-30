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
import DKImagePickerController


class AddPostSubleaseViewController: UIViewController,UINavigationControllerDelegate, UITextViewDelegate, UITextFieldDelegate {
    
    //constant labels
    @IBOutlet weak var defaultPicture: UIImageView!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    var imageArray = [UIImage]()
    var currentImage = 0

    
    var anythingEmpty = false
    let placeHolder: String = "Hi there, I am subleasing my place for Fall 2019"

    
    //Tap Camera Gesture to Open Camera or Gallery Library
    @IBAction func cameraTapGesture(_ sender: UITapGestureRecognizer)
    {
        let pickerController = DKImagePickerController()
        pickerController.didSelectAssets = { (assets: [DKAsset]) in
            for asset in assets {
                asset.fetchOriginalImage(completeBlock: { (imageUI, info) in
                    let size = CGSize(width: 394, height: 245)
                    let scaledImage = imageUI!.af_imageAspectScaled(toFill: size)
                    self.imageArray.append(scaledImage)
                    self.defaultPicture.image = self.imageArray[0]
                })
            }
        }
        pickerController.allowSwipeToSelect = true
        pickerController.allowMultipleTypes = true
        pickerController.showsCancelButton = true
        present(pickerController, animated: true)
    }
    
    //selecting and saving the image to variable and updating default picture image
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
//    {
//        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
//        let size = CGSize(width: 394, height: 245)
//        let scaledImage = image.af_imageAspectScaled(toFill: size)
//
//        self.defaultPicture.image = scaledImage
//        dismiss(animated: true, completion: nil)
//    }
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
            
            var parseImageArray:[PFFileObject] = []
            for image in imageArray
            {
                var imageData = image.pngData()!
                var file = PFFileObject(data: imageData)!
                parseImageArray.append(file)
            }
            
            
            //converting image into png data and save it
//            let imageData = defaultPicture.image!.pngData()!
//            let file = PFFileObject(data: imageData)
            
            Sublease["PosterPics"] = parseImageArray //file
            
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
    func textViewDidBeginEditing(_ textView: UITextView)
    {
        //show keyboard
        descriptionTextView.becomeFirstResponder()

        if descriptionTextView.text == placeHolder
        {
            descriptionTextView.textColor = UIColor.black
            descriptionTextView.text = String()
        }
    }
    func textViewDidEndEditing(_ textView: UITextView)
    {
        if descriptionTextView.text.isEmpty
        {
            descriptionTextView.textColor = UIColor.lightGray
            descriptionTextView.text = placeHolder
        }
    }
                    //Price and Address Text Fields Being cleaned upon edition
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        if (textField == priceTextField)
        {
            //show keyboard
            priceTextField.becomeFirstResponder()
            textField.text = String("$")
        }
        else if (textField == addressTextField )
        {
            //show keyboard
            addressTextField.becomeFirstResponder()
            textField.text = String()
        }
    }
                    //Price Text Field only Accepts Integer Values
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        if textField == priceTextField
        {
            let allowedCharacters = CharacterSet(charactersIn: "$0123456789")
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
        return true
    }
    

    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.descriptionTextView.delegate = self
        self.priceTextField.delegate = self
        self.addressTextField.delegate = self

        //Swipe Gesture for Image Swipe
        let imageSwipeLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(imageSwiped(gesture:)))
        imageSwipeLeftGesture.direction = .left
        let imageSwipeRightGesture = UISwipeGestureRecognizer(target: self, action: #selector(imageSwiped(gesture:)))
        imageSwipeRightGesture.direction = .right
        defaultPicture.addGestureRecognizer(imageSwipeLeftGesture)
        defaultPicture.addGestureRecognizer(imageSwipeRightGesture)
        
        defaultTextFormat()
        // Do any additional setup after loading the view.
    }
    
    @objc func imageSwiped(gesture: UIGestureRecognizer )
    {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer
        {
            switch swipeGesture.direction
            {
            case UISwipeGestureRecognizer.Direction.left:
                if currentImage != (imageArray.count - 1)
                {
                    currentImage += 1
                }
                else
                {
                    currentImage = 0
                }
                defaultPicture.image = imageArray[currentImage]
                print(imageArray.count)
                
            case UISwipeGestureRecognizer.Direction.right:
                if currentImage != 0
                {
                    currentImage -= 1
                }
                else
                {
                    currentImage = imageArray.count - 1
                }
                defaultPicture.image = imageArray[currentImage]
                print("swiping")
            default:
                break
            }
        }
    }
    
    
    
    
    //checks text fields for emptyness, and if so changes values of global variale anythinEmpty = true
    func emptyTextFields()
    {
        if addressTextField.text!.isEmpty
        {
            addressTextField.backgroundColor = UIColor.red
            self.anythingEmpty = true
        }
        else
        {
            addressTextField.backgroundColor = UIColor.white
        }
        if priceTextField.text!.isEmpty
        {
            priceTextField.backgroundColor = UIColor.red
            self.anythingEmpty = true
        }
        else
        {
            priceTextField.backgroundColor = UIColor.white
        }
        if descriptionTextView.text == self.placeHolder || descriptionTextView.text.isEmpty
        {
            descriptionTextView.textColor = UIColor.black
            descriptionTextView.backgroundColor = UIColor.red
            self.anythingEmpty = true
        }
        else
        {
            descriptionTextView.backgroundColor = UIColor.white
        }
        if defaultPicture.image == #imageLiteral(resourceName: "defaultPicture")
        {
            defaultPicture.backgroundColor = UIColor.red
            self.anythingEmpty = true
        }
        else
        {
            defaultPicture.backgroundColor = UIColor.white
        }
        reloadInputViews()
    }
    
    //Original looks of text fields
    func defaultTextFormat()
    {
        //Image Format
        //defaultPicture.image = UIImage(named: "defaultPicture")
        defaultPicture.image = #imageLiteral(resourceName: "defaultPicture")
            
        //Description Format //making textView look as textField
        descriptionTextView.textColor = UIColor.lightGray
        descriptionTextView.text = self.placeHolder
        self.descriptionTextView.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).cgColor
        self.descriptionTextView.layer.borderWidth = 1.0
        self.descriptionTextView.layer.cornerRadius = 5
    
        //Price Format
        self.priceTextField.keyboardType = .numbersAndPunctuation
        self.priceTextField.text = String()
        self.priceTextField.placeholder = "$1000"
        
        
        //Address Format
        self.addressTextField.text = String()
        self.addressTextField.placeholder = "600 W 26th Street, 78705"
    }
}
