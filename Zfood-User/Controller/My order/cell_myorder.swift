//
//  cell_myorder.swift
//  Zfood-User
//
//  Created by Mukesh on 30/07/19.
//  Copyright © 2019 WemakeAppz. All rights reserved.
//

import UIKit

class cell_myorder: UITableViewCell {

    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblChefName: UILabel!
    @IBOutlet weak var lblMonth: UILabel!
    @IBOutlet weak var lbldate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func addData(data:Order){
        
        self.lblChefName.text = data.chefdata.stRestaurantName
        self.lblAddress.text =  data.chefdata.address1
      
        if data.orderStatus == "0" || data.orderStatus == "1"{
            self.lblStatus.text =  "Placed"
        }else if data.orderStatus == "3" || data.orderStatus == "4"{
            self.lblStatus.text =  "Preparing"
        }else if data.orderStatus == "5"{
             self.lblStatus.text =  "Dispatch"
            //dispatch
        }else if data.orderStatus == "6"{
             self.lblStatus.text =  "Delivered"
            //delevered
        }
    self.lblMonth.text = data.startTimeMonth
        self.lbldate.text = data.startTimeDay
        self.lblTotal.text = "$" + data.totalAmount
    }
    
}
