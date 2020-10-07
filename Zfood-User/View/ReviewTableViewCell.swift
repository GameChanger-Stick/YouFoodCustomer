//
//  ReviewTableViewCell.swift
//  Zfood-User
//
//  Created by apple on 09/05/19.
//  Copyright © 2019 WemakeAppz. All rights reserved.
//

import UIKit
import Cosmos
class ReviewTableViewCell: UITableViewCell {

    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblComment: UILabel!
    @IBOutlet weak var lblRate: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var viewRate: CosmosView!
    @IBOutlet weak var imgV: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func getData(detail:Review?){
        if detail != nil{
            self.lblTitle.text = detail!.name
        self.lblComment.text = detail!.stDescription
        let dateformatt = DateFormatter()
            dateformatt.dateFormat = Constants.DATE_FORMAT.dateformattMain
        if let date =  dateformatt.date(from: detail!.dtAddedDate){
            self.lblRate.text = date.getElapsedInterval()
        }
            self.viewRate.rating = detail?.stFoodRating ?? 0.0
        }
       self.imgV.getImage(url: detail?.profile_picture ?? "")
        
    }
    
    func getData1(detail:InfoReview?){
        if detail != nil{
            self.imgV.getImage(url: detail?.reviewdata.profile_picture ?? "")
            self.lblTitle.text = detail?.reviewdata.stFirstName
            self.lblTitle.text = detail!.reviewdata.stRestaurantName ?? ""
            self.lblComment.text = detail!.reviewdata.stDescription
            let dateformatt = DateFormatter()
            dateformatt.dateFormat = Constants.DATE_FORMAT.dateformattMain
            if let date =  dateformatt.date(from: detail?.reviewdata.dtModifiedDate ?? ""){
                self.lblDate.text = date.getElapsedInterval()
            }
            self.viewRate.rating = detail?.reviewdata.stFoodRating ?? 0.0

            let dateformatt1 = DateFormatter()
                dateformatt1.dateFormat = Constants.DATE_FORMAT.dateformattMain
            if let date =  dateformatt1.date(from: (detail?.reviewdata.dtAddedDate)!){
                self.lblRate.text = date.getElapsedInterval()
            }
        }}
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
 
        // Configure the view for the selected state
    }
    
}
