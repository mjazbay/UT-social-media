//
//  NewsViewController.swift
//  UTSocial
//
//  Created by Maksat Zhazbayev on 4/12/19.
//  Copyright © 2019 Maksat Zhazbayev. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController{//, UITableViewDelegate, UITableViewDataSource {

    var webView = UIWebView()
    var webContent = """
<meta name='viewport' content='initial-scale=1.0'/>
<a class="twitter-timeline" href="https://twitter.com/UTAustin?ref_src=twsrc%5Etfw">Tweets by UTAustin</a> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>
"""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(webView)
        webView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        webView.loadHTMLString(webContent, baseURL: nil)
    }
    
    
//    var myTableView: UITableView!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//    myTableView =
//    {
//        let tableV = UITableView()
//        let screenSize = UIScreen.main.bounds
//        tableV.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height)
//        return tableV
//    }()
//
//        myTableView.register(ArticleCell.self, forCellReuseIdentifier: "newsCell")
//        myTableView.delegate = self
//        myTableView.dataSource = self
////        myTableView.estimatedRowHeight = 100
////        myTableView.rowHeight = UITableView.automaticDimension
//        self.view.addSubview(myTableView)
//
//    }
//
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 10
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = myTableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! ArticleCell
//        cell.likesLabel.text = "100"
//        cell.favoritesLabel.text = "1000"
//        cell.descriptionLabel.text = "Maksat Zhazbayev is going places!!"
//
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        myTableView.estimatedRowHeight = 200
//        return UITableView.automaticDimension
//    }

}

