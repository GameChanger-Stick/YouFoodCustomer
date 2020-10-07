//
//  cell_searchDishList.swift
//  Zfood-User
//
//  Created by bhavya on 2/7/20.
//  Copyright © 2020 WemakeAppz. All rights reserved.
//

import UIKit

class cell_searchDishList: UITableViewCell {
    @IBOutlet weak var lblChefName: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    
    @IBOutlet weak var notAvailableView: UIView!
    @IBOutlet weak var availableStatus: UILabel!
    @IBOutlet weak var lblDiscription: UILabel!
    @IBOutlet weak var dishName: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    func addData(data:Dishlist){
        self.lblChefName.text = data.chefData.chefName
        self.lblPrice.text =  "$"+data.stPrice
        lblDiscription.text = data.chefData.address1
        dishName.text = data.stDishName
        self.imgView.getImage(url: data.image ?? "")
        if data.chefData.todayAvailable{
            notAvailableView.isHidden = true
            self.availableStatus.text = "Available"
            self.availableStatus.textColor = #colorLiteral(red: 0.2783386707, green: 0.5934699178, blue: 0.04843180627, alpha: 0.9675192637)
        }else{
            notAvailableView.isHidden = false
            self.availableStatus.text = "Not Available"
            self.availableStatus.textColor = .lightGray
        }
    }
    
}
