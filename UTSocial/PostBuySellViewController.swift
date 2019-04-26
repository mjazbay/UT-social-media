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
    var imageArray = [#imageLiteral(resourceName: "defaultPicture"), #imageLiteral(resourceName: "utmenulogo"), #imageLiteral(resourceName: "defaultPicture"), #imageLiteral(resourceName: "utmenulogo") ]
    var currentImage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        view.addSubview(posterImage)
        
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
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer)
    {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer
        {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.left:
                currentImage += 1
                posterImage.image = imageArray[currentImage]
                print("swiping")
            case UISwipeGestureRecognizer.Direction.right:
                currentImage -= 1
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
        posterImage.image = imageArray[currentImage]
        posterImage.translatesAutoresizingMaskIntoConstraints = false
        posterImage.topAnchor.constraint(equalTo: view.topAnchor, constant: (self.navigationController?.navigationBar.frame.height)! + (self.navigationController?.navigationBar.frame.height)!).isActive = true
        posterImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        posterImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        posterImage.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 10).isActive = true
    }
}
