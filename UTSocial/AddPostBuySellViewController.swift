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

    var defaultImage = UIScrollView()
    var contentView = UIStackView()
    var postButton = UIBarButtonItem()
    var descriptionTextVIew = UITextView()
    var priceTextField = UITextField()
    var titleTextField = UITextField()
    var titleLabel = UILabel()
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
        defaultImage.addSubview(contentView)
        
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
            buySell["Title"] = titleTextField.text
            //Sublease["author"] = PFUser.current()
            
            var parseImageArray:[PFFileObject] = []
            for image in imageArray
            {
                let imageData = image.pngData()!
                let file = PFFileObject(data: imageData)!
                parseImageArray.append(file)
            }
                
            buySell["PosterPics"] = parseImageArray
            
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
        if titleTextField.text!.isEmpty
        {
            titleTextField.backgroundColor = .red
            self.anythingEmpty = true
        }
        else
        {
            titleTextField.backgroundColor = .white
            self.anythingEmpty = false
        }
//        if defaultImage.image == #imageLiteral(resourceName: "defaultPicture")
//        {
//            defaultImage.backgroundColor = UIColor.red
//            self.anythingEmpty = true
//        }
//        else
//        {
//            defaultImage.backgroundColor = UIColor.white
//            self.anythingEmpty = false
//        }
        reloadInputViews()

        
    }
    
    func defaultFrames()
    {
        self.view.backgroundColor = .white

        
        // default image configuration
        defaultImage.translatesAutoresizingMaskIntoConstraints = false
        defaultImage.topAnchor.constraint(equalTo: view.topAnchor, constant: (navigationController?.navigationBar.frame.height)! + (navigationController?.navigationBar.frame.height)! + 10).isActive = true
        defaultImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        defaultImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        defaultImage.heightAnchor.constraint(equalToConstant: 256).isActive = true
        
        //content view configuration
        for subview in self.contentView.subviews {
            self.contentView.removeArrangedSubview(subview)
        }
        let size = CGSize(width: 394, height: 245)
        let contentImage: UIImage = #imageLiteral(resourceName: "defaultPicture")
        let scaledImage = contentImage.af_imageAspectScaled(toFit: size)
//        contentView.addArrangedSubview(UIImageView(image: scaledImage))
        contentView.addSubview(UIImageView(image: scaledImage))
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: defaultImage.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: defaultImage.bottomAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: defaultImage.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: defaultImage.trailingAnchor).isActive = true
        
        //Title Text Field Configuration
        view.addSubview(titleLabel)
        view.addSubview(titleTextField)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: defaultImage.bottomAnchor, constant: 30).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        titleLabel.widthAnchor.constraint(lessThanOrEqualTo: titleTextField.widthAnchor).isActive = true
        
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        titleTextField.topAnchor.constraint(equalTo: defaultImage.bottomAnchor, constant: 30).isActive = true
        titleTextField.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 10).isActive = true
        titleTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
        titleLabel.font = UIFont.boldSystemFont(ofSize: titleLabel.font.pointSize + 2)
        titleLabel.text = "Title:"
        titleTextField.placeholder = "Macbook Air 2018 for Sale"
        titleTextField.borderStyle = .roundedRect
        titleTextField.textAlignment = .left
        titleTextField.text = String()
        
        
        //price label and textview configuration
        view.addSubview(priceLabel)
        view.addSubview(priceTextField)
        
        priceLabel.text = "Price:"
        priceLabel.font = UIFont.boldSystemFont(ofSize: priceLabel.font.pointSize + 2)
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        priceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        priceLabel.trailingAnchor.constraint(equalTo: priceTextField.leadingAnchor, constant: -10).isActive = true
        priceLabel.widthAnchor.constraint(lessThanOrEqualTo: priceTextField.widthAnchor).isActive = true
        
        priceTextField.text = String()
        priceTextField.placeholder = "$10000"
        priceTextField.translatesAutoresizingMaskIntoConstraints = false
        priceTextField.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 10).isActive = true
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

        descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true

        
        descriptionTextVIew.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextVIew.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10).isActive = true
        descriptionTextVIew.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        descriptionTextVIew.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        descriptionTextVIew.heightAnchor.constraint(equalToConstant: 200).isActive = true
    
    }
}
