//
//  slideInTransition.swift
//  UTSocial
//
//  Created by Maksat Zhazbayev on 4/9/19.
//  Copyright © 2019 Maksat Zhazbayev. All rights reserved.
//

import UIKit

class slideInTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    var isPresenting = false
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1.0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
       guard let toVC = transitionContext.viewController(forKey: .to),
        let fromVC = transitionContext.viewController(forKey: .from) else {return}
        
        let containerView = transitionContext.containerView
        
        let finalWidth = toVC.view.bounds.width * 0.8
        let finalHeight = toVC.view.bounds.height
     
        if isPresenting {
            //add main vc to container
            containerView.addSubview(toVC.view)
            //init frame of screen
            toVC.view.frame = CGRect(x: -finalWidth, y: 0, width: finalWidth, height: finalHeight)
        }
        
        //animate onto screen
        let transform = {
            toVC.view.transform = CGAffineTransform(translationX: finalWidth, y: 0)
        }
        //animate back of screen
        let identity = {
            fromVC.view.transform = .identity
        }
        //animation transition
        let duration = transitionDuration(using: transitionContext)
        let isCancelled = transitionContext.transitionWasCancelled
        UIView.animate(withDuration: duration, animations: {
            self.isPresenting ? transform(): identity()
            }) { (_) in
            transitionContext.completeTransition(!isCancelled)
        }
    }
}
