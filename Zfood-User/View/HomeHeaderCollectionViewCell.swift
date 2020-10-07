//
//  HomeHeaderCollectionViewCell.swift
//  Zfood-User
//
//  Created by apple on 06/05/19.
//  Copyright © 2019 WemakeAppz. All rights reserved.
//

import UIKit
var indexSelected = 0
class HomeHeaderCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var foodTypePicImageView: UIImageView!
    @IBOutlet weak var foodTypeLabel: UILabel!
    
    func addData(from:Cuisinedata,index:Int){
        self.foodTypeLabel.text = from.name
        if from.image == ""{
            self.foodTypePicImageView.image = #imageLiteral(resourceName: "91-911012_clip-art-stock-mexican-taco-png-icon-free")

        }else{
            self.foodTypePicImageView.getImage(url: from.image)

        }
        if indexSelected == index {
            mainView.backgroundColor = #colorLiteral(red: 0.8588235294, green: 0.9176470588, blue: 0.8509803922, alpha: 1)
            foodTypeLabel.textColor = #colorLiteral(red: 0.2274509804, green: 0.5882352941, blue: 0.1764705882, alpha: 1)
        }else{
            mainView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            foodTypeLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        allSidesShadowLight(mainView, color: #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 0.5))
        // Initialization code
    }

}
