//
//  MenuTableViewController.swift
//  UTSocial
//
//  Created by Maksat Zhazbayev on 4/9/19.
//  Copyright © 2019 Maksat Zhazbayev. All rights reserved.
//

import UIKit

enum MenuType: Int {
    case sublease
    case buy
    case events
}

class MenuTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let menuType = MenuType(rawValue: indexPath.row) else {return}
        dismiss(animated: true) {
            print("Dismissing: \(menuType)")
        }
    }

}
