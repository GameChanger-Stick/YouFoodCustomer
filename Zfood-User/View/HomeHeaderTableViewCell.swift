//
//  HomeHeaderTableViewCell.swift
//  Zfood-User
//
//  Created by apple on 06/05/19.
//  Copyright © 2019 WemakeAppz. All rights reserved.
//

import UIKit

class HomeHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var foodListCollectionView: UICollectionView!
    @IBOutlet weak var viewAllButton: UIButton!
    var cuisinesList : ModelChefList?
    var vc = UIViewController()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.foodListCollectionView.register(UINib(nibName: UICOLLECTIONVIEWCELL_IDENTIFIRE.HOME_HEADER, bundle: nil), forCellWithReuseIdentifier: UICOLLECTIONVIEWCELL_IDENTIFIRE.HOME_HEADER)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
  
}


