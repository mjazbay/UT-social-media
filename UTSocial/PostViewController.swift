//
//  PostViewController.swift
//  UTSocial
//
//  Created by Maksat Zhazbayev on 4/18/19.
//  Copyright © 2019 Maksat Zhazbayev. All rights reserved.
//

import UIKit
import AlamofireImage
import Parse

class PostViewController: UIViewController {
    
    var posterScrollView = UIScrollView()
    var posterContentView = UIStackView()
    var priceLabel = UILabel()
    var descriptionLabel = UILabel()
    var dateCreatedLabel = UILabel()
    var addressLabel = UILabel()
    var parseImageArray:[PFFileObject] = []
    var currentImage = 0
    var imageArray: [URL] = []


    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        view.addSubview(addressLabel)
        view.addSubview(posterScrollView)
        view.addSubview(priceLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(dateCreatedLabel)
        
        posterScrollView.addSubview(posterContentView)
        
        print(imageArray.count)
        
        
        defaultConstraints()
        addContentToScrollView()

    }
    
    func addContentToScrollView()
    {
        for url in imageArray
        {
            let imageView = UIImageView()
            imageView.af_setImage(withURL: url)
            posterContentView.addArrangedSubview(imageView)
        }
    }
    
    func defaultConstraints()
    {
                //ADDRESS
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        addressLabel.numberOfLines = 0
        addressLabel.textAlignment = .center
        addressLabel.textColor = .red
        addressLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: (self.navigationController?.navigationBar.frame.height)! + (self.navigationController?.navigationBar.frame.height)! + 10).isActive = true
        addressLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        addressLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        
                //POSTER IMAGE
        posterScrollView.translatesAutoresizingMaskIntoConstraints = false
        posterScrollView.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 10).isActive = true
        posterScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        posterScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        posterScrollView.heightAnchor.constraint(equalToConstant: 256).isActive = true
//        posterImage.af_setImage(withURL: imageArray[0])
        
                //CONTENT VIEW OF IMAGE
        posterContentView.translatesAutoresizingMaskIntoConstraints = false
        posterContentView.topAnchor.constraint(equalTo: posterScrollView.topAnchor).isActive = true
        posterContentView.leadingAnchor.constraint(equalTo: posterScrollView.leadingAnchor).isActive = true
        posterContentView.trailingAnchor.constraint(equalTo: posterScrollView.trailingAnchor).isActive = true
        posterContentView.bottomAnchor.constraint(equalTo: posterScrollView.bottomAnchor).isActive = true
        
                //PRICE LABEL
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.textColor = .red
        priceLabel.topAnchor.constraint(equalTo: posterScrollView.bottomAnchor, constant: 10).isActive = true
        priceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true

//                DATE CREATED LABEL
        dateCreatedLabel.translatesAutoresizingMaskIntoConstraints = false
        dateCreatedLabel.topAnchor.constraint(equalTo: posterScrollView.bottomAnchor, constant: 10).isActive = true
        dateCreatedLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        
//                DESCRIPTION LABEL
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.textAlignment = .left
        descriptionLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 10).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
//        descriptionLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 10).isActive = true
        
        descriptionLabel.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).cgColor
        descriptionLabel.layer.borderWidth = 1.0
        descriptionLabel.layer.cornerRadius = 5

    }
    
//class ends here
}
