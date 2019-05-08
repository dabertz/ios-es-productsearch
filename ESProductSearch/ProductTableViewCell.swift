//
//  ProductTableViewCell.swift
//  ESProductSearch
//
//  Created by Jolly Crisostomo on 2019/05/06.
//  Copyright © 2019 Jolly Crisostomo. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    //MARK: Properties
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
