//
//  PostViewController.swift
//  UTSocial
//
//  Created by Maksat Zhazbayev on 4/18/19.
//  Copyright © 2019 Maksat Zhazbayev. All rights reserved.
//

import UIKit

class PostViewController: UIViewController {
    
    let myButton = UIButton()
    var buttonConsts : [NSLayoutConstraint] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        defaultConstraints()
    }
    
    func defaultConstraints()
    {
        self.myButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.myButton.backgroundColor = UIColor.orange
        self.myButton.setTitle("Press Me!", for: .normal)
        self.myButton.setTitleColor(UIColor.white, for: .normal)
        self.view.addSubview(myButton)
        self.view.backgroundColor = UIColor.black
        
        //constraints
        let topConst = myButton.topAnchor.constraint(equalTo: view.topAnchor)
        let bottomConst = myButton.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        let leftConst = myButton.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        let rightConst = myButton.rightAnchor.constraint(equalTo: view.rightAnchor)
        buttonConsts = [topConst, bottomConst, leftConst, rightConst]
        NSLayoutConstraint.activate(buttonConsts)
    }
}
