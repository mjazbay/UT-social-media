//
//  pseudoMapVCViewController.swift
//  UTSocial
//
//  Created by Maksat Zhazbayev on 6/26/19.
//  Copyright © 2019 Maksat Zhazbayev. All rights reserved.
//

import UIKit
import WebKit

class pseudoMapVCViewController: UIViewController, WKNavigationDelegate {

    var webView = WKWebView()
    let url = URL(string: "https://maps.utexas.edu/#")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        
        let request = URLRequest(url: self.url!)
        webView.load(request)
        
        self.view = webView
//        self.view.addSubview(webView)
//        webView.frame = CGRect(x: 0, y: (self.navigationController?.navigationBar.bounds.height)!, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
}
