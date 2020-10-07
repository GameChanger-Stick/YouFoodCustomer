//
//  ChatListTableViewCell.swift
//  Zfood-User
//
//  Created by bhavya on 2/7/20.
//  Copyright © 2020 WemakeAppz. All rights reserved.
//

import UIKit

class ChatListTableViewCell: UITableViewCell {
    @IBOutlet var lblmsg: UILabel!
       @IBOutlet var lblOnline: UILabel!
       @IBOutlet var lblTime: UILabel!
       @IBOutlet var imgV: UIImageView!
       @IBOutlet var nameLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
