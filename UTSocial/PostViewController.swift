//
//  PostViewController.swift
//  UTSocial
//
//  Created by Maksat Zhazbayev on 4/18/19.
//  Copyright © 2019 Maksat Zhazbayev. All rights reserved.
//

import UIKit

class PostViewController: UIViewController {
    
    var posterImage = UIImageView()
    var priceLabel = UILabel()
    var descriptionLabel = UILabel()
    var dateCreatedLabel = UILabel()
    var addressLabel = UILabel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        view.addSubview(addressLabel)
        view.addSubview(posterImage)
        view.addSubview(priceLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(dateCreatedLabel)
        defaultConstraints()
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
        posterImage.translatesAutoresizingMaskIntoConstraints = false
        posterImage.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 10).isActive = true
        posterImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        posterImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
                //PRICE LABEL
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.textColor = .red
        priceLabel.topAnchor.constraint(equalTo: posterImage.bottomAnchor, constant: 10).isActive = true
        priceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true

//                DATE CREATED LABEL
        dateCreatedLabel.translatesAutoresizingMaskIntoConstraints = false
        dateCreatedLabel.topAnchor.constraint(equalTo: posterImage.bottomAnchor, constant: 10).isActive = true
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
