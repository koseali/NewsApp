//
//  FavoritesTableViewCell.swift
//  AppcentApp
//
//  Created by Ali Kose on 7.08.2021.
//

import UIKit

class FavoritesTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var newImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setFavoriteNewsTableViewCell(title: String, subtitle:String,imageUrl : String ){
        titleLabel.text = title
        subtitleLabel.text = subtitle
        
        let imageURL = URL(string: imageUrl)
        newImageView.kf.indicatorType = .activity
        newImageView.kf.setImage(with: imageURL , placeholder: UIImage(named: "blankImage"))
    }


}
