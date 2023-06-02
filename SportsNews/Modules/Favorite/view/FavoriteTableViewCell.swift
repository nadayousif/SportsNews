//
//  FavoriteTableViewCell.swift
//  SportsNews
//
//  Created by Nada youssef on 01/06/2023.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {

    @IBOutlet weak var imageFavorite: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var teamId: UILabel!
    
    @IBOutlet weak var favoriteView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
