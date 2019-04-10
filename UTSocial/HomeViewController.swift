//
//  HomeViewController.swift
//  UTSocial
//
//  Created by Maksat Zhazbayev on 4/9/19.
//  Copyright © 2019 Maksat Zhazbayev. All rights reserved.
//

import UIKit

class HomeViewController: UITabBarController { //UIViewController {
    
    let transition = slideInTransition()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func MenuButton(_ sender: UIBarButtonItem)
    {
   guard let menuVC = storyboard?.instantiateViewController(withIdentifier: "menuVC") else { return }
        
        menuVC.modalTransitionStyle = .flipHorizontal
        menuVC.transitioningDelegate = self
        
        present(menuVC, animated: true)
    }
}

extension HomeViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = true
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = false
        return transition
    }
}
