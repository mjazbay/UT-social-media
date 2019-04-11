//
//  VC1ViewController.swift
//  UTSocial
//
//  Created by Maksat Zhazbayev on 4/11/19.
//  Copyright © 2019 Maksat Zhazbayev. All rights reserved.
//

import UIKit

class VC1ViewController: UIViewController {

    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    var menuShowing = false
    
    @IBAction func menuButton(_ sender: Any)
    {
        if (menuShowing)
        {
            leadingConstraint.constant = -140
        }
        else
        {
            leadingConstraint.constant = 0
        }
        menuShowing = !menuShowing
        UIView.animate(withDuration: 0.3, animations: {self.view.layoutIfNeeded()})
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
