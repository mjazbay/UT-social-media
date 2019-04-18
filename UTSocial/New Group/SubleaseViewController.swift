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
    
    @IBOutlet weak var mainTableView: UITableView!
    
    //MENU BUTTON OPTIONS -> Slide in Menu
    @IBAction func menuButton(_ sender: Any)
    {
        let storyboard = UIStoryboard(name: "Menu", bundle: nil)
        guard let menuVC = storyboard.instantiateViewController(withIdentifier: "menuVC") as? MenuTableViewController else {return}
        
        menuVC.modalPresentationStyle = .overCurrentContext
        menuVC.transitioningDelegate = self
        present(menuVC, animated: true, completion: nil)
        
    }
    //Add a Post Button -> New View Controller
    @IBAction func addPost(_ sender: Any)
    {
        let storyboard = UIStoryboard(name: "Sublease", bundle: nil)
        guard let postingVC = storyboard.instantiateViewController(withIdentifier: "postSublease") as? AddPostSubleaseViewController else {return}
        present(postingVC, animated: true, completion: nil)
        
    }
    
    func queryData()
    {
        let query = PFQuery(className: "Sublease")
        query.order(byDescending: "createdAt")
        query.includeKeys(["Address", "Price", "Description", "PosterPic"])
        
        query.findObjectsInBackground { (posts, error) in
            if posts != nil
            {
                self.posts = posts!
                self.mainTableView.reloadData()
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mainTableView.delegate = self
        self.mainTableView.dataSource = self
        // Do any additional setup after loading the view.
        //self.queryData()
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
        let cell = mainTableView.dequeueReusableCell(withIdentifier: "subleaseCell") as! PostCellSubleaseTableViewCell
        
        let post = posts[indexPath.row]
        
        cell.addressLabel.text = post["Address"] as! String
        cell.priceLabel.text = post["Price"] as! String
        cell.descriptionLabel.text = post["Description"] as! String
       
        let imageFile = post["PosterPic"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!
        
        
        cell.mainPosterImageView.af_setImage(withURL: url)
        
        return cell
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
