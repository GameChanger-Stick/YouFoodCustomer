//
//  CuisineHeaderTableViewCell.swift
//  Zfood-User
//
//  Created by apple on 09/05/19.
//  Copyright © 2019 WemakeAppz. All rights reserved.
//

import UIKit

class CuisineHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dropdownImageView: UIImageView!
    @IBOutlet weak var expButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
