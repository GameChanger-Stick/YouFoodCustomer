//
//  cell_orderList.swift
//  Zfood-User
//
//  Created by bhavya on 1/8/20.
//  Copyright © 2020 WemakeAppz. All rights reserved.
//

import UIKit

class cell_orderList: UITableViewCell {

    @IBOutlet weak var btnOrderStatus: UIButton!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblDistance: UILabel!
    @IBOutlet weak var lblOrderType: UILabel!
    @IBOutlet weak var lblCustomerName: UILabel!
    
    @IBOutlet weak var lblplaced: UILabel!
    @IBOutlet weak var orderID: UILabel!
    @IBOutlet weak var btnViewOrder: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func addData(data:Order){
        
        self.lblCustomerName.text = data.chefdata.stRestaurantName
        self.lblOrderType.text = "Order Type: \(data.orderType == "1" ? "Delivery":"Pickup")"
        self.lblTime.text = "Delivery Time: " + data.deliveryTime
        self.orderID.text = "Order ID: " + data.orderNumber
        self.lblplaced.text = "Placed on: " + data.orderDate
        
        if data.orderStatus == "2"{
            btnViewOrder.backgroundColor = .darkGray
        }else{
            btnViewOrder.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)

        }
        
    }
    
}
