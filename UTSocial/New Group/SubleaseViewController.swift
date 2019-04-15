//
//  SubleaseViewController.swift
//  UTSocial
//
//  Created by Maksat Zhazbayev on 4/12/19.
//  Copyright © 2019 Maksat Zhazbayev. All rights reserved.
//

import UIKit

class SubleaseViewController: UIViewController {
    
    let transition = slideInTransition()
    let newViewController = NewsViewController()

    
    //MENU BUTTON OPTIONS
    @IBAction func menuButton(_ sender: Any)
    {
        let storyboard = UIStoryboard(name: "Menu", bundle: nil)
        guard let menuVC = storyboard.instantiateViewController(withIdentifier: "menuVC") as? MenuTableViewController else {return}
        
        menuVC.modalPresentationStyle = .overCurrentContext
        menuVC.transitioningDelegate = self
        present(menuVC, animated: true, completion: nil)

    }
    //ADDING A SUBLEASE POST HERE
    @IBAction func addPost(_ sender: Any)
    {
        let storyboard = UIStoryboard(name: "Sublease", bundle: nil)
        guard let postingVC = storyboard.instantiateViewController(withIdentifier: "postSublease") as? PostSubleaseViewController else {return}
        present(postingVC, animated: true, completion: nil)
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

extension SubleaseViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.menuShowing = true
        return transition
    }
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.menuShowing = false
        return transition
    }
}
