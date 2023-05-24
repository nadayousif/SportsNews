//
//  TableViewCell.swift
//  SportsNews
//
//  Created by Nada youssef on 24/05/2023.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var labelLeague: UILabel!
    
    @IBOutlet weak var imageLeague: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
