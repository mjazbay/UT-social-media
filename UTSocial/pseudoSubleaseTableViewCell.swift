//
//  pseudoSubleaseTableViewCell.swift
//  UTSocial
//
//  Created by Maksat Zhazbayev on 6/27/19.
//  Copyright © 2019 Maksat Zhazbayev. All rights reserved.
//

import UIKit

class pseudoSubleaseTableViewCell: UITableViewCell {

    var posterImageView: UIImageView = UIImageView()
    var priceLabel: UILabel = UILabel()
    var addressLabel: UILabel = UILabel()
    var descriptionLabel: UILabel = UILabel()
    var priceText: UILabel = UILabel()
    var addressText: UILabel = UILabel()
    var createdAtLabel: UILabel = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "subleaseCell")
        self.contentView.addSubview(posterImageView)
        self.contentView.addSubview(priceLabel)
        self.contentView.addSubview(addressLabel)
        self.contentView.addSubview(descriptionLabel)
        self.contentView.addSubview(priceText)
        self.contentView.addSubview(addressText)
        self.contentView.addSubview(createdAtLabel)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        default_frames()
    }

    func default_frames() {
        
        self.posterImageView.translatesAutoresizingMaskIntoConstraints = false
        self.posterImageView.translatesAutoresizingMaskIntoConstraints = false
        self.posterImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10).isActive = true
        self.posterImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10).isActive = true
        self.posterImageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10).isActive = true
        
        self.priceLabel.text = "Price:"
        self.priceLabel.textColor = .red
        self.priceLabel.font = UIFont.boldSystemFont(ofSize: priceText.font!.pointSize + 2)
        self.priceLabel.translatesAutoresizingMaskIntoConstraints = false
        self.priceLabel.topAnchor.constraint(equalTo: self.posterImageView.bottomAnchor, constant: 10).isActive = true
        self.priceLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10).isActive = true
        self.priceLabel.trailingAnchor.constraint(equalTo: priceText.leadingAnchor, constant: -5).isActive = true
        self.priceLabel.bottomAnchor.constraint(equalTo: self.descriptionLabel.topAnchor, constant: -10).isActive = true
        
        self.priceText.translatesAutoresizingMaskIntoConstraints = false
        self.priceText.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 10).isActive = true
        self.priceText.trailingAnchor.constraint(equalTo: addressLabel.leadingAnchor, constant: -5).isActive = true
        self.priceText.heightAnchor.constraint(equalTo: self.priceLabel.heightAnchor).isActive = true
        self.priceText.bottomAnchor.constraint(equalTo: self.descriptionLabel.topAnchor, constant: -10).isActive = true

        
        self.addressLabel.text = "Address:"
        self.addressLabel.textColor = .red
        self.addressLabel.font = UIFont.boldSystemFont(ofSize: addressText.font!.pointSize + 2)
        self.addressLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addressLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 10).isActive = true
        self.addressLabel.trailingAnchor.constraint(equalTo: addressText.leadingAnchor, constant: -5).isActive = true
        self.addressLabel.bottomAnchor.constraint(equalTo: self.descriptionLabel.topAnchor, constant: -10).isActive = true

        
        self.addressText.translatesAutoresizingMaskIntoConstraints = false
        self.addressText.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 10).isActive = true
        self.addressText.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10).isActive = true
        self.addressText.heightAnchor.constraint(equalTo: self.addressLabel.heightAnchor).isActive = true
        self.addressText.bottomAnchor.constraint(equalTo: self.descriptionLabel.topAnchor, constant: -10).isActive = true

        
        self.descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
//        self.descriptionTextView.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 10).isActive = true
        self.descriptionLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10).isActive = true
        self.descriptionLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10).isActive = true

        self.createdAtLabel.translatesAutoresizingMaskIntoConstraints = false
        self.createdAtLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10).isActive = true
        self.createdAtLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10).isActive = true
        self.createdAtLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10).isActive = true
        
    }
    
}
