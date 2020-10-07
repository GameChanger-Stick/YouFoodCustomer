//
//  SenderTableViewCell.swift
//  Zfood-User
//
//  Created by bhavya on 2/7/20.
//  Copyright © 2020 WemakeAppz. All rights reserved.
//

import UIKit

class SenderTableViewCell: UITableViewCell {
    @IBOutlet var lbltime: UILabel!
       @IBOutlet var lblMsgSender: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
