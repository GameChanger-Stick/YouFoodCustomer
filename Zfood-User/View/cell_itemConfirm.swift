//
//  cell_itemConfirm.swift
//  Zfood-User
//
//  Created by Mukesh on 29/07/19.
//  Copyright © 2019 WemakeAppz. All rights reserved.
//

import UIKit

class cell_itemConfirm: UITableViewCell {

    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblNameCount: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func addData(cart:CartData?){
        if cart == nil{
            return
        }
        self.lblPrice.text = "$\(cart!.dishInfo.totalPrice ?? "")"
        self.lblNameCount.text = "\(cart!.dishInfo.stDishName ?? "")(\(cart!.qty ?? ""))"
    }
    func addDataOrder(cart:OrderDetail?){
        if cart == nil{
            return
        }
        let qty = (cart?.qty ?? "0").FloatValue()
        let price = (cart!.price).FloatValue()
        let totallbl = qty * price
       let pri =  String.localizedStringWithFormat("%.2f", totallbl)
        self.lblPrice.text = "$\(pri)"
        self.lblNameCount.text = "\(cart?.dishname ?? "")(\(cart!.qty ?? ""))"
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
