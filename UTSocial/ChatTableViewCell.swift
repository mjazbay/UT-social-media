//
//  ChatTableViewCell.swift
//  UTSocial
//
//  Created by 谢阳欣雨 on 5/12/19.
//  Copyright © 2019 Maksat Zhazbayev. All rights reserved.
//

import UIKit

class ChatTableViewCell: UITableViewCell {
    
    var messageLabel: UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = 10
        label.layer.backgroundColor = UIColor.orange.cgColor
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "chatCell")
        constraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func constraints()
    {
        self.contentView.addSubview(messageLabel)
        messageLabel.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.5, constant: 0).isActive = true
        messageLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10).isActive = true
        messageLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10).isActive = true
//        messageLabel.center = self.contentView.center
        messageLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        messageLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true

    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
