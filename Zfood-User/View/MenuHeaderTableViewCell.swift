//
//  MenuHeaderTableViewCell.swift
//  Zfood-User
//  Created by apple on 06/05/19.
//  Copyright © 2019 WemakeAppz. All rights reserved.

import UIKit

class MenuHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var profilePicImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func addData(name:String,mobile:String,img:String){
       self.userNameLabel.text = name
        self.profilePicImageView.getImage(url: img)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
