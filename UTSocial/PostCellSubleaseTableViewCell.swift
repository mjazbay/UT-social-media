//
//  PostCellSubleaseTableViewCell.swift
//  UTSocial
//
//  Created by Maksat Zhazbayev on 4/15/19.
//  Copyright © 2019 Maksat Zhazbayev. All rights reserved.
//

import UIKit

class PostCellSubleaseTableViewCell: UITableViewCell {
    // my constants
    
    @IBOutlet weak var mainPosterImageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
