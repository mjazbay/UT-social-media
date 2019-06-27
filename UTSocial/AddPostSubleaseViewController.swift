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

    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var defaultPicture: UIScrollView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    var contentView = UIStackView()
    var imageArray = [UIImage]()
    var currentImage = 0
    
    var anythingEmpty = false
    let placeHolder: String = "Hi there, I am subleasing my place for Fall 2019"

    
    //Tap Camera Gesture to Open Camera or Gallery Library
    @IBAction func cameraTapGesture(_ sender: UITapGestureRecognizer) {
        let pickerController = DKImagePickerController()
        pickerController.didSelectAssets = { (assets: [DKAsset]) in
            for subview in self.contentView.subviews {
                self.contentView.removeArrangedSubview(subview)
            }
            for asset in assets {
                asset.fetchOriginalImage(completeBlock: { (imageUI, info) in
                    let size = CGSize(width: 394, height: 245)
                    let scaledImage = imageUI!.af_imageAspectScaled(toFill: size)
                    self.imageArray.append(scaledImage)
                    let scaledImageView = UIImageView(image: scaledImage)
                    self.contentView.addArrangedSubview(scaledImageView)
                    
                })
            }
    }
        pickerController.allowSwipeToSelect = true
        pickerController.allowMultipleTypes = true
        pickerController.showsCancelButton = true
        present(pickerController, animated: true)
        
//        for image in self.imageArray
//        {
//            self.contentView.addSubview(UIImageView(image: image))
//        }
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
            
            var parseImageArray:[PFFileObject] = []
            for image in imageArray
            {
                var imageData = image.pngData()!
                var file = PFFileObject(data: imageData)!
                parseImageArray.append(file)
            }
            
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

        defaultPicture.addSubview(contentView)
        
        defaultTextFormat()
        self.hideKeyboardWhenTappedAround()
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
        reloadInputViews()
    }
    
    //Original looks of text fields
    func defaultTextFormat()
    {
        //Poster Picture Format
        defaultPicture.translatesAutoresizingMaskIntoConstraints = false
        defaultPicture.topAnchor.constraint(equalTo: self.view.topAnchor, constant: (navigationController?.navigationBar.frame.height)! + (navigationController?.navigationBar.frame.height)! + 10).isActive = true
        defaultPicture.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        defaultPicture.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
        defaultPicture.widthAnchor.constraint(equalToConstant: 394).isActive = true
        defaultPicture.heightAnchor.constraint(equalToConstant: 245).isActive = true
        
        //address label and textfield
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        addressLabel.topAnchor.constraint(equalTo: defaultPicture.bottomAnchor, constant: 10).isActive = true
        addressLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        addressLabel.trailingAnchor.constraint(equalTo: addressTextField.leadingAnchor, constant: -10).isActive = true
        
        addressTextField.translatesAutoresizingMaskIntoConstraints = false
        addressTextField.topAnchor.constraint(equalTo: defaultPicture.bottomAnchor, constant: 10).isActive = true
        addressTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
        addressTextField.centerYAnchor.constraint(equalTo: addressLabel.centerYAnchor).isActive = true
        
        //price label and textfield
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 20).isActive = true
        priceLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        priceLabel.trailingAnchor.constraint(greaterThanOrEqualTo: priceTextField.leadingAnchor, constant: -10).isActive = true
        
        priceTextField.translatesAutoresizingMaskIntoConstraints = false
        priceTextField.topAnchor.constraint(equalTo: addressTextField.bottomAnchor, constant: 20).isActive = true
        priceTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
        priceTextField.widthAnchor.constraint(equalTo: addressTextField.widthAnchor).isActive = true
        priceTextField.centerYAnchor.constraint(equalTo: priceLabel.centerYAnchor).isActive = true
        
        //description label
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 20).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10).isActive = true
        descriptionTextView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        descriptionTextView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
        descriptionTextView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20).isActive = true
        
        
        
        //Content Format
        let size = CGSize(width: 394, height: 245)
        let contentImage: UIImage = #imageLiteral(resourceName: "defaultPicture")
        let scaledImage = contentImage.af_imageAspectScaled(toFit: size)
        contentView.addArrangedSubview(UIImageView(image: scaledImage))
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: defaultPicture.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: defaultPicture.bottomAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: defaultPicture.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: defaultPicture.trailingAnchor).isActive = true
        
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

    //class ends here
}

extension AddPostSubleaseViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AddPostSubleaseViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
