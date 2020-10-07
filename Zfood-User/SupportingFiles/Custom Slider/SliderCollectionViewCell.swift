//
//  SliderCollectionViewCell.swift
//  Zfood-User
//
//  Created by apple on 09/05/19.
//  Copyright © 2019 WemakeAppz. All rights reserved.
//

import UIKit

class SliderCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var barLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setCellData(title: String, index: Int, tappedIndex: Int, selectedTitleColor: UIColor, deselectedTitleColor: UIColor, selectedBarColor: UIColor, deselectedBarColor: UIColor) {
        self.titleLabel.text = title
        if index == tappedIndex {
            self.titleLabel.textColor = selectedTitleColor
            self.barLabel.backgroundColor = selectedBarColor
        }else {
            self.titleLabel.textColor = deselectedTitleColor
            self.barLabel.backgroundColor = deselectedBarColor
        }
    }

}
