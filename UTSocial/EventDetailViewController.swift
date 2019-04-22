//
//  EventDetailViewController.swift
//  UTSocial
//
//  Created by 谢阳欣雨 on 4/22/19.
//  Copyright © 2019 Maksat Zhazbayev. All rights reserved.
//

import UIKit
import Parse
import AlamofireImage

class EventDetailViewController: UIViewController {

    var post = PFObject(className: "eventPost")
    
    @IBOutlet weak var detailPoster: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = post["Title"] as? String
        timeLabel.text = post["Time"] as? String
        descriptionLabel.text = post["Description"] as? String
        
        let imageFile = post["Poster"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!
        
        detailPoster.af_setImage(withURL: url)
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
