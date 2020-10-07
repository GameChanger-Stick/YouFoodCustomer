//
//  cell_address.swift
//  Zfood-User
//
//  Created by Mukesh on 26/07/19.
//  Copyright © 2019 WemakeAppz. All rights reserved.
//

import UIKit

class cell_address: UITableViewCell {
    
    @IBOutlet var btnEdit: UIButton!
    @IBOutlet var btnradio: UIButton!
    @IBOutlet var lblAddressPhone: UILabel!
    @IBOutlet var lblname: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
//    func addData(from data:InfoAddress){
//        self.lblname.text = data.name
//        self.lblAddressPhone.text = data.address1
//    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
