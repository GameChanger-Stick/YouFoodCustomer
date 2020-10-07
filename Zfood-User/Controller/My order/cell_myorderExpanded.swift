//
//  cell_myorderExpanded.swift
//  Zfood-User
//  Created by Mukesh on 30/07/19.
//  Copyright © 2019 WemakeAppz. All rights reserved.
//

import UIKit
import Cosmos

class cell_myorderExpanded: UITableViewCell {

    @IBOutlet weak var lblDate: UILabel!
    
    @IBOutlet weak var btnrate: UIButton!
    @IBOutlet weak var rateView: CosmosView!
    @IBOutlet weak var heightView: NSLayoutConstraint!
    @IBOutlet weak var lblTotalPayment: UILabel!
    @IBOutlet weak var lblDeliveryCharge: UILabel!
    @IBOutlet weak var lblServiceCharge: UILabel!
    @IBOutlet weak var lblSubTotal: UILabel!
    @IBOutlet weak var LblStatus: UILabel!
    @IBOutlet weak var lblOrderId: UILabel!
    @IBOutlet weak var lblChefName: UILabel!
    @IBOutlet weak var lblMonth: UILabel!
    @IBOutlet var heightTableview: NSLayoutConstraint!
    @IBOutlet weak var lblDelivered: DynamicSizeLabel!
    @IBOutlet weak var lblInTransitTime: DynamicSizeLabel!
    @IBOutlet weak var lblDispatchTime: DynamicSizeLabel!
    @IBOutlet weak var lblPreparingTime: DynamicSizeLabel!
    @IBOutlet weak var lblPlaceTime: DynamicSizeLabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet var imgDelivered: UIImageView!
    @IBOutlet var imgDispatch: UIImageView!
    @IBOutlet var imgPreparing: UIImageView!
    @IBOutlet var imgPlace: UIImageView!
    var items : Order?
    
    @IBOutlet weak var btnRateTrackOrder: UIButton!
    @IBOutlet var imgintranit: UIImageView!
    @IBOutlet var tableview: UITableView!
    override func awakeFromNib() {
        super.awakeFromNib()
       tableview.delegate = self
        tableview.dataSource = self
        tableview.register(UINib(nibName: "cell_itemConfirm", bundle: nil), forCellReuseIdentifier: "cell_itemConfirm")
        let imgArr = [imgPlace,imgDispatch,imgintranit,imgDelivered,imgPreparing]
        for obj in imgArr{
            obj?.layer.cornerRadius = (obj?.frame.height)!/2
            obj?.clipsToBounds = true
        }
        // Initialization code
    }
    override func layoutSubviews() {
        //heightTableview.constant = tableview.contentSize.height
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    func allDefault(){
        self.imgPlace.image = UIImage(named: "ic_done_all_white")
         self.imgPreparing.image = UIImage(named: "ic_restaurant_menu_white")
         self.imgDispatch.image = UIImage(named: "ic_directions_bike_white")
         self.imgintranit.image = UIImage(named: "ic_local_shipping_white")
         self.imgDelivered.image = UIImage(named: "delivered")
         self.lblPlaceTime.text = ""
         self.lblPreparingTime.text = ""
         self.lblDispatchTime.text = ""
         self.lblInTransitTime.text = ""
         self.lblDelivered.text = ""
    }
    func addData(data:Order){
        allDefault()
       
        self.rateView.isHidden = true
         self.heightView.constant = 0
        self.lblChefName.text = data.chefdata.stRestaurantName
        self.lblAddress.text =  data.chefdata.address1
        self.lblOrderId.text = "ID:" + data.orderNumber
        if data.orderStatus == "0" || data.orderStatus == "1"{
            self.LblStatus.text =  "Placed"
            self.imgPlace.image = #imageLiteral(resourceName: "ic_done_all_white1")
            self.lblPlaceTime.text = data.order_accepted_time
        }else if data.orderStatus == "3" || data.orderStatus == "4"{
            self.LblStatus.text =  data.orderStatus == "3" ? "Preparing":"Ready for deliver"
            self.imgPlace.image = #imageLiteral(resourceName: "ic_done_all_white1")
            self.lblPlaceTime.text = data.order_accepted_time
            self.lblPreparingTime.text  = data.preparing_time
            self.imgPreparing.image = #imageLiteral(resourceName: "ic_on_the_way1")
            //preparing
        }else if data.orderStatus == "5"{
            self.LblStatus.text  = "On the way"
            self.imgPlace.image = #imageLiteral(resourceName: "ic_done_all_white1")
            self.lblPlaceTime.text = data.order_accepted_time
            
            self.lblPreparingTime.text  = data.preparing_time
            self.imgPreparing.image = #imageLiteral(resourceName: "ic_on_the_way1")
            
            self.lblInTransitTime.text  = data.ready_to_deliver_time
            self.imgintranit.image = #imageLiteral(resourceName: "ic_directions_bike_white1")
            
            self.imgDispatch.image = #imageLiteral(resourceName: "ic_local_shipping_white1")
            self.lblDispatchTime.text = data.on_the_way_time
            //dispatch
        }else if data.orderStatus == "6"{
              self.LblStatus.text  = "Delivered"
             self.heightView.constant = 40
            self.imgPlace.image = #imageLiteral(resourceName: "ic_done_all_white1")
            self.lblPlaceTime.text = data.order_accepted_time
            
            self.lblPreparingTime.text  = data.preparing_time
            self.imgPreparing.image = #imageLiteral(resourceName: "ic_on_the_way1")
            
            self.lblInTransitTime.text  = data.ready_to_deliver_time
            self.imgintranit.image = #imageLiteral(resourceName: "ic_directions_bike_white1")
            
            self.imgDispatch.image = #imageLiteral(resourceName: "ic_local_shipping_white1")
            self.lblDispatchTime.text = data.on_the_way_time
            
            self.imgDelivered.image = #imageLiteral(resourceName: "delivered_green1")
            self.lblDelivered.text = data.deliver_time
            //delevered
        }
        self.lblSubTotal.text = "$" + data.totalAmount
        self.lblServiceCharge.text = "$49"
        self.lblDeliveryCharge.text = "$30"
        self.lblTotalPayment.text = "$" + data.totalAmount
        self.lblMonth.text = data.startTimeMonth
        self.lblDate.text = data.startTimeDay
        if data.ratingdata.inChefId != nil{
            self.rateView.isHidden = false
            self.heightView.constant = 0
            let ret = data.ratingdata.stFoodRating
            let dsa = Double(ret ?? "0")
            self.rateView.rating = dsa ?? 0
        }else{
            self.rateView.isHidden = true
        }
        
    }
    

}
extension cell_myorderExpanded : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.orderDetail.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell_itemConfirm", for: indexPath) as! cell_itemConfirm
        cell.addDataOrder(cart: (items?.orderDetail[indexPath.row] ?? nil))
        cell.selectionStyle = .none
        return cell
    }
    
    
}
