//
//  cell_paymentVC.swift
//  Zfood-User
//
//  Created by bhavya on 1/7/20.
//  Copyright © 2020 WemakeAppz. All rights reserved.
//
//using
import UIKit

class cell_paymentVC: UITableViewCell {

    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var imgV: UIImageView!
    @IBOutlet weak var lblAccountNumber: UILabel!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblBankNAme: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func addData(card:CARDLIST?){
        if card != nil{
            self.lblBankNAme.text = ""
            self.lblUserName.text = "Name: " + (card?.name ?? "")
            self.lblAccountNumber.text = "**** **** **** " + card!.cardNo
            if card?.isSelected ?? true{
                viewMain.layer.borderColor = #colorLiteral(red: 0.2783386707, green: 0.5934699178, blue: 0.04843180627, alpha: 1)
                viewMain.layer.borderWidth = 1
            }else{
                viewMain.layer.borderWidth = 0
            }
        }
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
