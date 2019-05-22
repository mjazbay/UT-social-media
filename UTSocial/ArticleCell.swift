import UIKit
import AlamofireImage
class ArticleCell: UITableViewCell
{
    let descriptionLabel: UILabel =
    {
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        //change border shape, color, text size etc
//        text.layer.backgroundColor = UIColor.red.cgColor
        text.layer.cornerRadius = 10
        text.layer.borderColor = UIColor.gray.cgColor
        return text
    }()
    let likesView: UIImageView =
    {
        let like = UIImageView()
        like.translatesAutoresizingMaskIntoConstraints = false
        return like
    }()
    let likesLabel: UILabel =
    {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let favoritesView: UIImageView =
    {
        let star = UIImageView()
        star.translatesAutoresizingMaskIntoConstraints = false
        return star
    }()
    let favoritesLabel: UILabel =
    {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let userPic: UIImageView =
    {
        let uPic = UIImageView()
        uPic.translatesAutoresizingMaskIntoConstraints = false
        return uPic
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "newsCell")
        addViews()
        constraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViews()
    {
        self.contentView.addSubview(userPic)
        self.contentView.addSubview(likesView)
        self.contentView.addSubview(likesLabel)
        self.contentView.addSubview(favoritesView)
        self.contentView.addSubview(favoritesLabel)
        self.contentView.addSubview(descriptionLabel)
    }
    func constraints()
    {
        ///Constant Images
        let defaultPic: UIImage = #imageLiteral(resourceName: "defaultPicture")
        let size1 = CGSize(width: 10, height: 10)
        let size2 = CGSize(width: 50, height: 50)
        let scaledImage1 = defaultPic.af_imageAspectScaled(toFit: size1)
        let scaledImage2 = defaultPic.af_imageAspectScaled(toFit: size2)
        userPic.image = scaledImage2
        likesView.image = scaledImage2
        favoritesView.image = scaledImage2
        ///
        
        let cellSize = self.contentView.layoutMarginsGuide
        
        userPic.topAnchor.constraint(equalTo: cellSize.topAnchor,constant: 10).isActive = true
        userPic.leadingAnchor.constraint(equalTo: cellSize.leadingAnchor).isActive = true
        userPic.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor, constant: -10).isActive = true
        userPic.widthAnchor.constraint(equalToConstant: 100).isActive = true
        userPic.heightAnchor.constraint(equalToConstant: 100).isActive = true

        likesView.topAnchor.constraint(equalTo: cellSize.topAnchor, constant: 10).isActive = true
        likesView.leadingAnchor.constraint(equalTo: userPic.trailingAnchor, constant: 20).isActive = true

        likesView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        likesView.heightAnchor.constraint(equalToConstant: 50).isActive = true

        likesLabel.topAnchor.constraint(equalTo: cellSize.topAnchor, constant: 10).isActive = true
        likesLabel.widthAnchor.constraint(lessThanOrEqualTo: likesView.widthAnchor).isActive = true
        likesLabel.leadingAnchor.constraint(equalTo: likesView.trailingAnchor, constant: 10).isActive = true

        favoritesView.topAnchor.constraint(equalTo: cellSize.topAnchor, constant: 10).isActive = true
        favoritesView.leadingAnchor.constraint(equalTo: likesLabel.trailingAnchor, constant: 10).isActive = true
        favoritesView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        favoritesView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        favoritesLabel.topAnchor.constraint(equalTo: cellSize.topAnchor, constant: 10).isActive = true
        favoritesLabel.leadingAnchor.constraint(equalTo: favoritesView.trailingAnchor, constant: 10).isActive = true
        favoritesLabel.trailingAnchor.constraint(equalTo: cellSize.trailingAnchor, constant: -10).isActive = true

        descriptionLabel.bottomAnchor.constraint(equalTo: cellSize.bottomAnchor, constant: -10).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: cellSize.leadingAnchor, constant: 10).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: cellSize.trailingAnchor, constant: -10).isActive = true

        
    }
    
}
