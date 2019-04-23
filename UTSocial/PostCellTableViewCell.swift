//
//  PostCellTableViewCell.swift
//  UTSocial
//
//  Created by Maksat Zhazbayev on 4/20/19.
//  Copyright © 2019 Maksat Zhazbayev. All rights reserved.
//

import UIKit

class PostCellTableViewCell: UITableViewCell {

    var priceLabel = UILabel()
    var descriptionLabel = UILabel()
    var posterImage = UIImageView() //= UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    var titlelabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "postCell")
        self.contentView.addSubview(priceLabel)
        self.contentView.addSubview(posterImage)
        self.contentView.addSubview(descriptionLabel)
        self.contentView.addSubview(titlelabel)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews()
    {
        super.layoutSubviews()
        defaultFormat()
    }
    
    func defaultFormat()
    {
        //        Poster Pic Formation
        posterImage.translatesAutoresizingMaskIntoConstraints = false
        posterImage.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        posterImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        posterImage.trailingAnchor.constraint(equalTo: titlelabel.leadingAnchor, constant: -10).isActive = true
        posterImage.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        posterImage.widthAnchor.constraint(equalToConstant: 100)
        
        //        Title Label Formation
        titlelabel.translatesAutoresizingMaskIntoConstraints = false
        titlelabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10).isActive = true
        titlelabel.leadingAnchor.constraint(equalTo: posterImage.trailingAnchor, constant: 10).isActive = true
        titlelabel.trailingAnchor.constraint(equalTo: priceLabel.leadingAnchor, constant: -10).isActive = true
//        titlelabel.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor, constant: 10).isActive = true
        
        //         Price Label Formation
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.numberOfLines = 0
        priceLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10).isActive = true
        priceLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10).isActive = true
//        priceLabel.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor, constant: 10).isActive = true
        
        //        Description Text Formation
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .left
        descriptionLabel.leadingAnchor.constraint(equalTo: posterImage.trailingAnchor, constant: 10).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10).isActive = true
//        descriptionLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 10).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: titlelabel.bottomAnchor,constant: 10).isActive = true
        //look up insets
        
        
        
    }
//class ends here
}
