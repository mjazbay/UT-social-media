//
//  PostBuySellViewController.swift
//  UTSocial
//
//  Created by Maksat Zhazbayev on 4/25/19.
//  Copyright © 2019 Maksat Zhazbayev. All rights reserved.
//

import UIKit
import AlamofireImage

class PostBuySellViewController: UIViewController {

                    //     Constants
    var posterScrollView = UIScrollView() //UIImageView()
    var posterContentView = UIStackView()
    var priceLabel = UILabel()
    var createdAtLabel = UILabel()
    var descriptionTextView = UITextView()
    var imageArray: [URL] = [] // this should not be instantiated
    var currentImage = 0
    var titleLabel = UILabel()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        view.addSubview(posterScrollView)
        view.addSubview(priceLabel)
        view.addSubview(createdAtLabel)
        view.addSubview(descriptionTextView)
        view.addSubview(titleLabel)
        view.addSubview(posterScrollView)
        posterScrollView.addSubview(posterContentView)
        
        defaultConstraints()
        addImageToScrollView()
    }
    
    func addImageToScrollView()
    {
//            let size = CGSize(width: 256, height: 256)
//            for imageURL in imageArray
//            {
//                let imageView = UIImageView()
//                imageView.af_setImage(withURL: imageURL)
//                let scaledImage = imageView.image?.af_imageAspectScaled(toFill: size)
//                let contentView = UIImageView(image: scaledImage)
//                posterContentView.addArrangedSubview(contentView)
//            }
        for url in imageArray
        {
            let imageView = UIImageView()
            imageView.af_setImage(withURL: url)
            posterContentView.addArrangedSubview(imageView)
        }
    }

    
    //default constraints
    func defaultConstraints()
    {
        //        TItle Label Location
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: (self.navigationController?.navigationBar.frame.height)! + (self.navigationController?.navigationBar.frame.height)!).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: titleLabel.font.pointSize + 5)
        titleLabel.textColor = .red
        titleLabel.numberOfLines = 0
//        titleLabel.text = "Macbook Pro 2012 for Sale"
        
        
        //Poster Image Location
        posterScrollView.translatesAutoresizingMaskIntoConstraints = false
        posterScrollView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true //, constant: (self.navigationController?.navigationBar.frame.height)! + (self.navigationController?.navigationBar.frame.height)!).isActive = true
        posterScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        posterScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        posterScrollView.heightAnchor.constraint(equalToConstant: 256).isActive = true
        
        //Content View Location
        posterContentView.translatesAutoresizingMaskIntoConstraints = false
        posterContentView.topAnchor.constraint(equalTo: posterScrollView.topAnchor).isActive = true
        posterContentView.leadingAnchor.constraint(equalTo: posterScrollView.leadingAnchor).isActive = true
        posterContentView.trailingAnchor.constraint(equalTo: posterScrollView.trailingAnchor).isActive = true
        posterContentView.bottomAnchor.constraint(equalTo: posterScrollView.bottomAnchor).isActive = true
        
        //Price Label Location
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.topAnchor.constraint(equalTo: posterScrollView.bottomAnchor, constant: 10).isActive = true
        priceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
//        priceLabel.text = "$10000"
        priceLabel.textColor = .red
        priceLabel.textAlignment = .center
        priceLabel.font = priceLabel.font.withSize(titleLabel.font.pointSize)
        
        
        //createdAt Label Location
        createdAtLabel.translatesAutoresizingMaskIntoConstraints = false
        createdAtLabel.topAnchor.constraint(equalTo: posterScrollView.bottomAnchor, constant: 10).isActive = true
        createdAtLabel.leadingAnchor.constraint(equalTo: priceLabel.trailingAnchor, constant: 10).isActive = true
        createdAtLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        priceLabel.widthAnchor.constraint(lessThanOrEqualTo: createdAtLabel.widthAnchor).isActive = true
        createdAtLabel.textAlignment = .right
//        createdAtLabel.text = "created at 12.01.19 @ 10:20 pm"
        
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextView.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 10).isActive = true
        descriptionTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        descriptionTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        descriptionTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30).isActive = true
        descriptionTextView.font = descriptionTextView.font?.withSize(descriptionTextView.font!.pointSize + 5)
        descriptionTextView.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).cgColor
        descriptionTextView.layer.borderWidth = 1.0
        descriptionTextView.layer.cornerRadius = 5
    }
//end of class
}
