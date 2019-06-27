//
//  SubleaseViewController.swift
//  UTSocial
//
//  Created by Maksat Zhazbayev on 4/12/19.
//  Copyright © 2019 Maksat Zhazbayev. All rights reserved.
//

import UIKit
import Parse
import AlamofireImage

class SubleaseViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    let transition = slideInTransition()
    let newViewController = NewsViewController()
    var posts = [PFObject]()
    let myRefreshControl = UIRefreshControl()
    let formatter = DateFormatter()
    var imageArray: [URL] = []
    
    
//    @IBOutlet weak var mainTableView: UITableView!
    var mainTableView = UITableView()
    
    //MENU BUTTON OPTIONS -> Slide in Menu
    @IBAction func menuButton(_ sender: Any)
    {
        let storyboard = UIStoryboard(name: "Menu", bundle: nil)
        guard let menuVC = storyboard.instantiateViewController(withIdentifier: "menuVC") as? MenuTableViewController else {return}
    
        let navController = UINavigationController(rootViewController: menuVC)
        navController.modalPresentationStyle = .overCurrentContext
        navController.transitioningDelegate = self
        present(navController, animated: true, completion: nil)
    }
    
    //Add a Post Button -> New View Controller
    @IBAction func addPost(_ sender: Any)
    {
//        let storyboard = UIStoryboard(name: "Sublease", bundle: nil)
//        guard let postingVC = storyboard.instantiateViewController(withIdentifier: "addPostNav") as? UINavigationController else {return}
//        present(postingVC, animated: true, completion: nil)
//        let transitionVC = AddPostSubleaseViewController()
//        navigationController?.pushViewController(postingVC, animated: true)
          performSegue(withIdentifier: "toAddPost", sender: self)
    }
    
    @objc func queryData()
    {
        let query = PFQuery(className: "Sublease")
        query.order(byDescending: "createdAt")
        query.includeKeys(["Address", "Price", "Description", "PosterPics"])
        
        query.findObjectsInBackground { (posts, error) in
            if posts != nil
            {
                self.posts = posts!
                self.mainTableView.reloadData()
                self.myRefreshControl.endRefreshing()
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mainTableView.delegate = self
        self.mainTableView.dataSource = self
        self.view = self.mainTableView
        self.mainTableView.estimatedRowHeight = 100
        self.mainTableView.rowHeight = UITableView.automaticDimension
        self.mainTableView.register(pseudoSubleaseTableViewCell.self, forCellReuseIdentifier: "subleaseCell")
        // Do any additional setup after loading the view.
                
        myRefreshControl.addTarget(self, action: #selector(queryData), for: .valueChanged)
        mainTableView.refreshControl = myRefreshControl
        
        self.navigationController?.navigationBar.tintColor = .orange

        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        self.queryData()
    }
    
    //Filling the Cell for Each Row with Data acquired from server
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = mainTableView.dequeueReusableCell(withIdentifier: "subleaseCell") as! pseudoSubleaseTableViewCell
        
        let post = posts[indexPath.row]
        
        cell.addressText.text = post["Address"] as? String
        cell.priceText.text = post["Price"] as? String
        cell.descriptionLabel.text = post["Description"] as? String

                // Adding Post Creation Date (date -> String conversion)
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let myString = formatter.string(for: post.createdAt)
        let myDate = formatter.date(from: myString!)
        formatter.dateFormat = "dd-MMM-yyyy"
        let finalString = formatter.string(for: myDate)
        cell.createdAtLabel.text = finalString

                //    Setting up the Image for the Poster
        let imageFile = post["PosterPics"] as! [PFFileObject]
        for file in imageFile
        {
            imageArray.append(URL(string: file.url!)!)
        }
//        let urlString = imageFile.url!
//        let url = URL(string: urlString)!
                /////
        cell.posterImageView.af_setImage(withURL: imageArray[0])
        
        print(imageArray.count)
        imageArray = []

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let post = posts[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        let transitionVC = PostViewController()
        transitionVC.descriptionLabel.text = post["Description"] as? String
        transitionVC.priceLabel.text = post["Price"] as? String
        transitionVC.addressLabel.text = post["Address"] as? String
        transitionVC.descriptionLabel.text = post["Description"] as? String
        
        // Adding Post Creation Date (date -> String conversion)
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let myString = formatter.string(for: post.createdAt)
        let myDate = formatter.date(from: myString!)
        formatter.dateFormat = "dd-MMM-yyyy"
        let finalString = formatter.string(for: myDate)
        transitionVC.dateCreatedLabel.text = finalString
        
        //    Setting up the Image for the Poster
        let imageFile = post["PosterPics"] as! [PFFileObject]
        for file in imageFile
        {
            transitionVC.imageArray.append(URL(string: file.url!)!)
        }

        /////

        
        navigationController?.pushViewController(transitionVC, animated: true)
    }
    
}
//class ends here


//Neccessary for Slide in Animation
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
