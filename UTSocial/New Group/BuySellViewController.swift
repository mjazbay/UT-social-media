//
//  BuySellViewController.swift
//  UTSocial
//
//  Created by Maksat Zhazbayev on 4/12/19.
//  Copyright © 2019 Maksat Zhazbayev. All rights reserved.
//

import UIKit

class BuySellViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var mainTableView: UITableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()

        mainTableView.register(PostCellTableViewCell.self, forCellReuseIdentifier: "postCell")

        //get main screen bounds
        let screenSize: CGRect = UIScreen.main.bounds
        let screendWidth = screenSize.width
        let screenHeight = screenSize.height
        
        mainTableView.frame = CGRect(x: 0, y: 0, width: screendWidth, height: screenHeight)
//        mainTableView.rowHeight = UITableView.automaticDimension
//        mainTableView.estimatedRowHeight = 100
        
        mainTableView.delegate = self
        mainTableView.dataSource = self
        
        
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        self.view.addSubview(mainTableView)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! PostCellTableViewCell
        cell.priceLabel.text = "$10000"
        cell.posterImage.image = UIImage(imageLiteralResourceName: "defaultPicture")
        cell.descriptionLabel.text = "Hi there, I am selling this photoapparat!, Address: 600 w 26th St for pick up!!"
        cell.titlelabel.text = "13 Apple MacBook Air 1.8Ghz Core i5"
        
        return cell
    }
//    //configuring each row's HEIGHT
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        mainTableView.rowHeight = UITableView.automaticDimension
        return 200//mainTableView.estimatedRowHeight

    }
    
    
}
