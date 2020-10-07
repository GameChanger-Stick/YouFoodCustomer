//
//  CartItemTableViewCell.swift
//  Zfood-User
//
//  Created by apple on 10/05/19.
//  Copyright © 2019 WemakeAppz. All rights reserved.
//

import UIKit

class CartItemTableViewCell: UITableViewCell {

    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var dishImageView: UIImageView!
    
    @IBOutlet weak var dishNameLabel: UILabel!
   
    @IBOutlet weak var dishPriceLabel: UILabel!
    @IBOutlet weak var dishQuantityLabel: UILabel!
    
    @IBOutlet weak var lblChefNAme: UILabel!
    @IBOutlet weak var btnIncrease: UIButton!
    @IBOutlet weak var btnDecrease: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func addDATA(data:CartData){
        dishNameLabel.text = data.dishInfo.stDishName
       dishImageView.getImage(url: data.imgDish)
        dishPriceLabel.text = "Price: $" + (data.dishInfo.stPrice  ?? "")
        dishQuantityLabel.text = data.qty
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
