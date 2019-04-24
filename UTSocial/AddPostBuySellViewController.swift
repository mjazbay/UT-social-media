//
//  AddPostBuySellViewController.swift
//  UTSocial
//
//  Created by Maksat Zhazbayev on 4/23/19.
//  Copyright © 2019 Maksat Zhazbayev. All rights reserved.
//

import UIKit

class AddPostBuySellViewController: UIViewController {

    var defaultImage = UIImageView()
    var postButton = UIBarButtonItem()
    var descriptionTextVIew = UITextView()
    var priceTextField = UITextField()
    let imageTapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
    var priceLabel = UILabel()
    var descriptionLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        defaultFrames()
    
    }
    
    @objc func postButtonPressed()
    {
        
    }
    
    @objc func imageTapped()
    {
        
    }
    
    func defaultFrames()
    {
        self.view.backgroundColor = .white

        //Post button configuration
        postButton = UIBarButtonItem(title: "Post", style: .plain, target: self, action: #selector(postButtonPressed))
        navigationItem.rightBarButtonItem = postButton
        navigationItem.rightBarButtonItem?.tintColor = .orange

        //left Back Button configuration
        navigationItem.leftBarButtonItem?.tintColor = .orange
        navigationItem.leftBarButtonItem?.title = "Maksat"
        
        // default image configuration
        view.addSubview(defaultImage)
        defaultImage.isUserInteractionEnabled = true
        defaultImage.addGestureRecognizer(imageTapGesture)
        
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
        
        priceTextField.placeholder = "$10000"
        priceTextField.translatesAutoresizingMaskIntoConstraints = false
        priceTextField.topAnchor.constraint(equalTo: defaultImage.bottomAnchor, constant: 30).isActive = true
//        priceTextField.leadingAnchor.constraint(equalTo: priceLabel.trailingAnchor, constant: 10).isActive = true
        priceTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
//        priceTextField.widthAnchor.constraint(greaterThanOrEqualTo: priceLabel.widthAnchor).isActive = true
        priceTextField.borderStyle = .roundedRect
        priceTextField.textAlignment = .left
    }
    
}
