//
//  HomeViewController.swift
//  UTSocial
//
//  Created by Maksat Zhazbayev on 4/11/19.
//  Copyright © 2019 Maksat Zhazbayev. All rights reserved.
//

import UIKit

class HomeViewController: UITabBarController {
    let transition = slideInTransition()
    
    @IBAction func menuButton(_ sender: Any)
    {
        // Setting Up Slide In Menu Option
        let storyboard = UIStoryboard(name: "Menu", bundle: nil)
        guard let menuVC = storyboard.instantiateViewController(withIdentifier: "menuVC") as? MenuTableViewController else {return}
        
        menuVC.modalPresentationStyle = .overCurrentContext
        menuVC.transitioningDelegate = self
        present(menuVC, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
extension HomeViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.menuShowing = true
        return transition
    }
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.menuShowing = false
        return transition
    }
}
