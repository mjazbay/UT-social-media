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
    let transition = slideInTransition()



    @objc func menuShowUp()
    {
        let storyboard = UIStoryboard(name: "Menu", bundle: nil)
        guard let menuVC = storyboard.instantiateViewController(withIdentifier: "menuVC") as? MenuTableViewController else {return}
        let navController = UINavigationController(rootViewController: menuVC)
        navController.modalPresentationStyle = .overCurrentContext
        navController.transitioningDelegate = self
        present(navController, animated: true, completion: nil)
    }
    
    @objc func addPost()
    {
        let addPostVC = AddPostBuySellViewController()
        self.navigationController?.pushViewController(addPostVC, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        mainTableView.register(PostCellTableViewCell.self, forCellReuseIdentifier: "postCell")

        //get main screen bounds
        let screenSize: CGRect = UIScreen.main.bounds
        let screendWidth = screenSize.width
        let screenHeight = screenSize.height
        
        mainTableView.frame = CGRect(x: 0, y: 0, width: screendWidth, height: screenHeight)
        
        mainTableView.delegate = self
        mainTableView.dataSource = self
        
        
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        self.view.addSubview(mainTableView)
        
        //menu button configuration
        let menuButton = UIBarButtonItem(image: #imageLiteral(resourceName: "utmenulogo"), style: .plain, target: self, action: #selector(BuySellViewController.menuShowUp))
        self.navigationItem.leftBarButtonItem = menuButton
        menuButton.tintColor = UIColor.orange
        
        //add post button configuration
        let addPostButton = UIBarButtonItem()
        addPostButton.style = .plain
        addPostButton.title = "Add Post"
        addPostButton.tintColor = .orange
        addPostButton.target = self
        addPostButton.action = #selector(addPost)
    
        self.navigationItem.rightBarButtonItem = addPostButton
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
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
 //class ends here
}
//extension for slide in menu
extension BuySellViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.menuShowing = true
        return transition
    }
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.menuShowing = false
        return transition
    }
}
