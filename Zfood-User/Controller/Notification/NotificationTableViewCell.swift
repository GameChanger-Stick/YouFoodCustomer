//
//  NotificationTableViewCell.swift
//  Zfood-User
//
//  Created by bhavya on 2/5/20.
//  Copyright © 2020 WemakeAppz. All rights reserved.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {

    @IBOutlet weak var lblREply: UILabel!
    @IBOutlet weak var viewMAin: UIView!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblDiscription: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func addDataToCurrentCell(data:SingleNotificationModel?){
        if data != nil{
            lblREply.text = ""
            self.lblTitle.text = data!.title
        self.lblDiscription.text = data!.descriptionField
            self.lblTime.text = data!.created.convertTo(format: "MM-dd-yyyy HH:mm")
            if data?.type == "5"{//anouncement
                 self.lblREply.text = "Explore Chef"
                self.viewMAin.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
                  }else if data?.type == "4"{//reply
                self.lblREply.text = "Reply"
                     self.viewMAin.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
                  }
            else if data?.type == "3"{//reply
            self.lblREply.text = "My Request"
                 self.viewMAin.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
              
            } else{
                 self.viewMAin.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
              
                  }
        }
        layoutIfNeeded()
      
          
    }
    
}
