//
//  AddPostBuySellViewController.swift
//  UTSocial
//
//  Created by Maksat Zhazbayev on 4/23/19.
//  Copyright © 2019 Maksat Zhazbayev. All rights reserved.
//

import UIKit
import AlamofireImage
import Parse
import DKImagePickerController

class AddPostBuySellViewController: UIViewController, UINavigationControllerDelegate, UITextViewDelegate, UITextFieldDelegate {

    var defaultImage = UIImageView()
    var postButton = UIBarButtonItem()
    var descriptionTextVIew = UITextView()
    var priceTextField = UITextField()
    var priceLabel = UILabel()
    var descriptionLabel = UILabel()
    let placeHolder = "Hi there, I am selling my school supplies."
    var anythingEmpty = true
    var imageArray = [UIImage]()
    var currentImage = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        priceTextField.delegate = self
        descriptionTextVIew.delegate = self

        //Right (Post) button configuration
        postButton = UIBarButtonItem(title: "Post", style: .plain, target: self, action: #selector(postButtonPressed))
        navigationItem.rightBarButtonItem = postButton
        navigationItem.rightBarButtonItem?.tintColor = .orange
        
        self.navigationItem.title = "Add Post"
        

        
        //Tap Gesture for Image Selection
        let imageTapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped(_:)))
        imageTapGesture.numberOfTapsRequired = 1
        imageTapGesture.numberOfTouchesRequired = 1
        defaultImage.isUserInteractionEnabled = true
        defaultImage.addGestureRecognizer(imageTapGesture)
        view.addSubview(defaultImage)
        
        //Swipe Gesture for Image Swipe
        let imageSwipeLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(imageSwiped(gesture:)))
        imageSwipeLeftGesture.direction = .left
        let imageSwipeRightGesture = UISwipeGestureRecognizer(target: self, action: #selector(imageSwiped(gesture:)))
        imageSwipeRightGesture.direction = .right
        defaultImage.addGestureRecognizer(imageSwipeLeftGesture)
        defaultImage.addGestureRecognizer(imageSwipeRightGesture)

        //default constraints auto-layout
        defaultFrames()
        
        }
    
    @objc func postButtonPressed()
    {
        //save the post if only all of the fields are not empty
        areTextFieldsEmpty()
        if !(anythingEmpty)
            {
            //initializing parse class for Buy ' Sell
                let buySell = PFObject(className: "BuySell") //in swift 5 you can use ## to escape
            buySell["Price"] = priceTextField.text
            buySell["Description"] = descriptionTextVIew.text
            //Sublease["author"] = PFUser.current()
            
            //converting image into png data and save it
            let imageData = defaultImage.image!.pngData()!
            let file = PFFileObject(data: imageData)
            
            buySell["PosterPic"] = file
            
            buySell.saveInBackground { (success, error) in
                if success
                {
                    print("Saved")
                    self.defaultFrames()
                }
                else
                {
                    print("Error Saving:  \(error?.localizedDescription)")
                }
            }
        }
    }
                    //    Selecting Images from Gallery
    @objc func imageTapped(_ sender: UITapGestureRecognizer)
    {
        let pickerController = DKImagePickerController()
        pickerController.didSelectAssets = { (assets: [DKAsset]) in
            for asset in assets {
                asset.fetchOriginalImage(completeBlock: { (imageUI, info) in
                    let size = CGSize(width: 256, height: 256)
                    let scaledImage = imageUI!.af_imageAspectScaled(toFill: size)
                    self.imageArray.append(scaledImage)
                    self.defaultImage.image = self.imageArray[0]
                })
            }
        }
        pickerController.allowSwipeToSelect = true
        pickerController.allowMultipleTypes = true
        pickerController.showsCancelButton = true
        present(pickerController, animated: true)
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
                    defaultImage.image = imageArray[currentImage]
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
                    defaultImage.image = imageArray[currentImage]
                print("swiping")
            default:
                break
            }
        }
    }
    
                    //when texts begin editing clear fields, when ends editing bring the default format
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.becomeFirstResponder()
        textView.text = String()
        textView.textColor = .black
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
        textField.text = "$"
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.text = placeHolder
        textView.textColor = .lightGray
    }

    
                    //check if any of the textfields are empty, if so, return true
    func areTextFieldsEmpty()
    {
        if priceTextField.text!.isEmpty
        {
            priceTextField.backgroundColor = UIColor.red
            self.anythingEmpty = true
        }
        else
        {
            priceTextField.backgroundColor = UIColor.white
            self.anythingEmpty = false
        }
        if descriptionTextVIew.text == self.placeHolder || descriptionTextVIew.text.isEmpty
        {
            descriptionTextVIew.textColor = UIColor.black
            descriptionTextVIew.backgroundColor = UIColor.red
            self.anythingEmpty = true
        }
        else
        {
            descriptionTextVIew.backgroundColor = UIColor.white
            self.anythingEmpty = false
        }
        if defaultImage.image == #imageLiteral(resourceName: "defaultPicture")
        {
            defaultImage.backgroundColor = UIColor.red
            self.anythingEmpty = true
        }
        else
        {
            defaultImage.backgroundColor = UIColor.white
            self.anythingEmpty = false
        }
        reloadInputViews()

        
    }
    
    func defaultFrames()
    {
        self.view.backgroundColor = .white

        
        // default image configuration

        defaultImage.translatesAutoresizingMaskIntoConstraints = false
        defaultImage.image = #imageLiteral(resourceName: "defaultPicture")
        defaultImage.topAnchor.constraint(equalTo: view.topAnchor, constant: (navigationController?.navigationBar.frame.height)! + (navigationController?.navigationBar.frame.height)! + 10).isActive = true
        defaultImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        defaultImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        
        //price label and textview configuration
        view.addSubview(priceLabel)
        view.addSubview(priceTextField)
        
        priceLabel.text = "Price:"
        priceLabel.font = UIFont.boldSystemFont(ofSize: priceLabel.font.pointSize + 2)
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.topAnchor.constraint(equalTo: defaultImage.bottomAnchor, constant: 30).isActive = true
        priceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        priceLabel.trailingAnchor.constraint(equalTo: priceTextField.leadingAnchor, constant: -10).isActive = true
        priceLabel.widthAnchor.constraint(lessThanOrEqualTo: priceTextField.widthAnchor).isActive = true
        
        priceTextField.text = String()
        priceTextField.placeholder = "$10000"
        priceTextField.translatesAutoresizingMaskIntoConstraints = false
        priceTextField.topAnchor.constraint(equalTo: defaultImage.bottomAnchor, constant: 30).isActive = true
        priceTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        priceTextField.borderStyle = .roundedRect
        priceTextField.textAlignment = .left
        
        //description label and description text view configuration
        view.addSubview(descriptionLabel)
        view.addSubview(descriptionTextVIew)
        
        descriptionLabel.text = "Description:"
        descriptionLabel.font = UIFont.boldSystemFont(ofSize: descriptionLabel.font.pointSize + 2)
        
        descriptionTextVIew.textColor = .lightGray
        descriptionTextVIew.text = placeHolder
        descriptionTextVIew.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).cgColor
        descriptionTextVIew.layer.borderWidth = 1.0
        descriptionTextVIew.layer.cornerRadius = 5
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 30).isActive = true
//        descriptionLabel.trailingAnchor.constraint(equalTo: descriptionTextVIew.leadingAnchor, constant: 10).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
//        descriptionLabel.widthAnchor.constraint(lessThanOrEqualTo: descriptionTextVIew.widthAnchor).isActive = true
        
        descriptionTextVIew.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextVIew.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10).isActive = true
        descriptionTextVIew.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        descriptionTextVIew.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 10).isActive = true
        descriptionTextVIew.heightAnchor.constraint(equalToConstant: 200).isActive = true
    
    }
}
