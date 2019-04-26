//
//  PostBuySellViewController.swift
//  UTSocial
//
//  Created by Maksat Zhazbayev on 4/25/19.
//  Copyright © 2019 Maksat Zhazbayev. All rights reserved.
//

import UIKit

class PostBuySellViewController: UIViewController {

                    //     Constants
    var posterImage = UIImageView()
    var priceLabel = UILabel()
    var createdAtLabel = UILabel()
    var descriptionTextView = UITextView()
    var imageArray = [#imageLiteral(resourceName: "defaultPicture"), #imageLiteral(resourceName: "utmenulogo"), #imageLiteral(resourceName: "defaultPicture"), #imageLiteral(resourceName: "utmenulogo") ] // this should not be instantiated
    var currentImage = 0
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        view.addSubview(posterImage)
        view.addSubview(priceLabel)
        view.addSubview(createdAtLabel)
        view.addSubview(descriptionTextView)
        
        
        //SWIPE gesture for images
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture(gesture:)))
        swipeRight.direction = .right
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture(gesture:)))
        swipeLeft.direction = .left
        posterImage.addGestureRecognizer(swipeRight)
        posterImage.addGestureRecognizer(swipeLeft)
        posterImage.isUserInteractionEnabled = true
        defaultConstraints()
        
    }
    //Image SWIPE function
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer)
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
                posterImage.image = imageArray[currentImage]
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
                posterImage.image = imageArray[currentImage]
                print("swiping")
            default:
                break
            }
        }
    }
    
    //default constraints
    func defaultConstraints()
    {
        //Poster Image Location
        posterImage.image = imageArray[currentImage]
        posterImage.translatesAutoresizingMaskIntoConstraints = false
        posterImage.topAnchor.constraint(equalTo: view.topAnchor, constant: (self.navigationController?.navigationBar.frame.height)! + (self.navigationController?.navigationBar.frame.height)!).isActive = true
        posterImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        posterImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
//        posterImage.bottomAnchor.constraint(equalTo: priceLabel.topAnchor, constant: 10).isActive = true
        
        //Price Label Location
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.topAnchor.constraint(equalTo: posterImage.bottomAnchor, constant: 10).isActive = true
        priceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        priceLabel.text = "$10000"
        
        //createdAt Label Location
        createdAtLabel.translatesAutoresizingMaskIntoConstraints = false
        createdAtLabel.topAnchor.constraint(equalTo: posterImage.bottomAnchor, constant: 10).isActive = true
        createdAtLabel.leadingAnchor.constraint(equalTo: priceLabel.trailingAnchor, constant: 10).isActive = true
        createdAtLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        priceLabel.widthAnchor.constraint(lessThanOrEqualTo: createdAtLabel.widthAnchor).isActive = true
        createdAtLabel.text = "created at 12.01.19 @ 10:20 pm"
        
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextView.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 10).isActive = true
        descriptionTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        descriptionTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        descriptionTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 10).isActive = true
        descriptionTextView.text = "Selling this camera, barely used, like new condition"
    }
//end of class
}
