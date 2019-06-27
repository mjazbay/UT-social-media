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
    var createdAt = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "postCell")
        self.contentView.addSubview(priceLabel)
        self.contentView.addSubview(posterImage)
        self.contentView.addSubview(descriptionLabel)
        self.contentView.addSubview(titlelabel)
        self.contentView.addSubview(createdAt)
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
        let marginGuide = self.contentView.layoutMarginsGuide
        //        Title Label Formation
        titlelabel.font = UIFont.boldSystemFont(ofSize: descriptionLabel.font.pointSize + 2)
        titlelabel.textAlignment = .center
        titlelabel.numberOfLines = 0
        titlelabel.translatesAutoresizingMaskIntoConstraints = false
        titlelabel.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        titlelabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor, constant: 10).isActive = true
        titlelabel.heightAnchor.constraint(equalTo: priceLabel.heightAnchor).isActive = true
        titlelabel.widthAnchor.constraint(greaterThanOrEqualTo: priceLabel.widthAnchor).isActive = true
        //         Price Label Formation
        priceLabel.font = UIFont.boldSystemFont(ofSize: descriptionLabel.font.pointSize + 2)
        priceLabel.textColor = .red
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.numberOfLines = 0
        priceLabel.textAlignment = .right
        priceLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        priceLabel.leadingAnchor.constraint(equalTo: titlelabel.trailingAnchor, constant: 10).isActive = true
        priceLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor, constant: -10).isActive = true

        //        Poster Pic Formation
        posterImage.translatesAutoresizingMaskIntoConstraints = false
        posterImage.topAnchor.constraint(equalTo: titlelabel.bottomAnchor, constant: 10).isActive = true
        posterImage.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor, constant:  5).isActive = true
        posterImage.trailingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor, constant: -10).isActive = true
        posterImage.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor, constant: 10).isActive = true
        posterImage.widthAnchor.constraint(equalTo: descriptionLabel.widthAnchor).isActive = true
        
        
        //        Description Text Formation
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .left
        descriptionLabel.topAnchor.constraint(equalTo: titlelabel.bottomAnchor, constant: 10).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10).isActive = true
        descriptionLabel.heightAnchor.constraint(equalToConstant: posterImage.frame.height - 40).isActive = true
        
        // Created At Label Formation
        createdAt.translatesAutoresizingMaskIntoConstraints = false
        createdAt.textAlignment = .left
        createdAt.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor, constant: -10).isActive = true
        createdAt.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor, constant: 5).isActive = true
        
        
        //look up insets
        
        
        
    }
//class ends here
}
