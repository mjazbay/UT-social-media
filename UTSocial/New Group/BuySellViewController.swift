//
//  BuySellViewController.swift
//  UTSocial
//
//  Created by Maksat Zhazbayev on 4/12/19.
//  Copyright © 2019 Maksat Zhazbayev. All rights reserved.
//

import UIKit
import Parse
import AlamofireImage

class BuySellViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var mainTableView: UITableView = UITableView()
    let transition = slideInTransition()
    var posts = [PFObject]()
    let myRefreshControl = UIRefreshControl()
    var imageArray: [URL] = []
    let formatter = DateFormatter()




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
        mainTableView.estimatedRowHeight = 100
        mainTableView.rowHeight = UITableView.automaticDimension
        
        
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        self.view.addSubview(mainTableView)
        myRefreshControl.addTarget(self, action: #selector(query_data), for: .valueChanged)
        mainTableView.refreshControl = myRefreshControl
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
        self.navigationItem.title = "Buy\'Sell"
        self.navigationController?.navigationBar.tintColor = .orange
        
        query_data()
        
    }
    

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


    @objc func query_data()
    {
        let query = PFQuery(className: "BuySell")
        query.order(byDescending: "createdAt")
        query.includeKeys(["Price", "Description", "Title", "PosterPics"])
        
        query.findObjectsInBackground { (posts, error) in
            if posts != nil
            {
                self.posts = posts!
                self.mainTableView.reloadData()
                self.myRefreshControl.endRefreshing()
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! PostCellTableViewCell
        let post = posts[indexPath.row]
        
        cell.priceLabel.text = post["Price"] as! String
        cell.descriptionLabel.text = post["Description"] as! String
        cell.titlelabel.text = post["Title"] as! String
        
        // Adding Post Creation Date (date -> String conversion)
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let myString = formatter.string(for: post.createdAt)
        let myDate = formatter.date(from: myString!)
        formatter.dateFormat = "dd-MMM-yyyy"
        let finalString = formatter.string(for: myDate)
        cell.createdAt.text = finalString
        
        //    Setting up the Image for the Poster
        let imageFile = post["PosterPics"] as! [PFFileObject]
        for file in imageFile
        {
            imageArray.append(URL(string: file.url!)!)
        }
//        let myDefaultImage = UIImageView()
//        myDefaultImage.af_setImage(withURL: imageArray[0])
//        let size = CGSize(width: 100,height: 100)
//        let myScaledDefaultImage = myDefaultImage.image?.af_imageAspectScaled(toFill: size)
//        cell.posterImage.image = myScaledDefaultImage
//
        cell.posterImage.af_setImage(withURL: imageArray[0])
        imageArray = []
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let transitionVC = PostBuySellViewController()
        let post = posts[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        transitionVC.descriptionTextView.text = post["Description"] as! String
        transitionVC.priceLabel.text = post["Price"] as! String
        transitionVC.titleLabel.text = post["Title"] as! String

        // Adding Post Creation Date (date -> String conversion)
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let myString = formatter.string(for: post.createdAt)
        let myDate = formatter.date(from: myString!)
        formatter.dateFormat = "dd-MMM-yyyy"
        let finalString = formatter.string(for: myDate)
        transitionVC.createdAtLabel.text = finalString
        
        //    Setting up the Image for the Poster
        let imageFile = post["PosterPics"] as! [PFFileObject]
        for file in imageFile
        {
            transitionVC.imageArray.append(URL(string: file.url!)!)
        }
        
        self.navigationController?.pushViewController(transitionVC, animated: true)
        
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
