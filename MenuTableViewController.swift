//
//  MenuTableViewController.swift
//  UTSocial
//
//  Created by Maksat Zhazbayev on 4/11/19.
//  Copyright © 2019 Maksat Zhazbayev. All rights reserved.
//

import UIKit

enum MenuType: Int {
    case sublease
    case buy
    case events }

class MenuTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let menuType = MenuType(rawValue: indexPath.row)
//        //dismiss(animated: true, completion: nil)
//        let storyboard = UIStoryboard(name: "Sublease", bundle: nil)
//        if let vc = storyboard.instantiateViewController(withIdentifier: "sublease") as? SubleaseViewController {
//            present(vc, animated: true, completion: nil)
//        }
        
        let buySellVC = BuySellViewController()
        present(buySellVC, animated: true, completion: nil)
    }
    
    @IBAction func dismissMenu(_ sender: Any)
    {
        dismiss(animated: true, completion: nil)
    }
    
//end of class
}
