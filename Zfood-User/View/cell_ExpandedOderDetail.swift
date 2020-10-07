//
//  cell_ExpandedOderDetail.swift
//  Zfood-User
//
//  Created by bhavya on 1/9/20.
//  Copyright © 2020 WemakeAppz. All rights reserved.
//

import UIKit
import Cosmos

class cell_ExpandedOderDetail: UITableViewCell {

    @IBOutlet weak var heightTrackOrder: NSLayoutConstraint!
    @IBOutlet weak var lblchefname: UILabel!
    @IBOutlet weak var lblOrderID: UILabel!
    @IBOutlet weak var rejectView: UIView!
    @IBOutlet weak var btnReject: UIButton!
    
    @IBOutlet weak var rateView: CosmosView!
    @IBOutlet weak var btnRepeatOrder: UIButton!
    @IBOutlet weak var btnDelivered: UIButton!
    @IBOutlet weak var btnOutforDelivery: UIButton!
    @IBOutlet weak var btnPreparing: UIButton!
    @IBOutlet weak var bntplaced: UIButton!
    @IBOutlet weak var line3: UIView!
    @IBOutlet weak var line4: UIView!
    @IBOutlet weak var line2: UIView!
    @IBOutlet weak var line1: UIView!
    @IBOutlet weak var lblTotalPrice: UILabel!
    @IBOutlet weak var lbllocation: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var lblOrderType: UILabel!
    @IBOutlet weak var heightTable: NSLayoutConstraint!
    @IBOutlet weak var lblOrderReadyText: UILabel!
    @IBOutlet weak var lblDistance: UILabel!
    @IBOutlet weak var lblOutForDelivery: UILabel!
    @IBOutlet weak var heightReadyTxt: NSLayoutConstraint!
    @IBOutlet weak var imgPlace: UIButton!
    @IBOutlet weak var imgPreparing: UIButton!
    @IBOutlet weak var LblStatus: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var imgDelivered: UIButton!
    @IBOutlet weak var imgOutForDelivery: UIButton!
    var items : Order?
    @IBOutlet weak var btnRateYourOrder: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.tableView.delegate = self
        self.tableView.dataSource = self
          tableView.register(UINib(nibName: "cell_itemConfirm", bundle: nil), forCellReuseIdentifier: "cell_itemConfirm")
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func allDefault(){
        self.imgPlace.setImage(img: UIImage(named: "order accepted")!)
        self.imgPreparing.setImage(img: UIImage(named: "preparning dish gray")!)
        self.imgOutForDelivery.setImage(img: UIImage(named: "out-for-delivery-gray")!)
        self.imgDelivered.setImage(img: UIImage(named: "ic_delivered_grey")!)
        self.heightReadyTxt.constant = 0
        heightTrackOrder.constant = 0
        self.lblOrderReadyText.isHidden = true
        btnRepeatOrder.isHidden = true
        self.rejectView.isHidden = true
        self.btnReject.isEnabled = false
     }
    
     func addData(data:Order){
         allDefault()
        if data.ratingdata.stFoodRating == nil {
            self.rateView.isHidden = true
            self.btnRateYourOrder.isHidden = false
        }else{
            self.btnRateYourOrder.isHidden = true
         self.rateView.isHidden = false
            let fd : Double = Double(data.ratingdata.stFoodRating) ?? 0.0
            self.rateView.rating = fd
        }
        if items?.orderType == "1"{
                   lblOutForDelivery.text = "Out for delivery"
            self.lbllocation.text =  data.chefdata.smallAddress

               }else{
                  lblOutForDelivery.text = "Ready to pickup"
            self.lbllocation.text =  data.chefdata.address1

               }
        self.items = data
         self.lblchefname.text = data.chefdata.stRestaurantName
         self.lblOrderID.text = "ID:" + data.orderNumber
        self.lblTime.text = "Time: " + data.orderDate
        self.lblTotalPrice.text = "Total: $" + data.totalAmount
        self.lblDistance.text = "Distance: " + data.distance + " mi"
        self.heightTable.constant = CGFloat(data.orderDetail.count * 30)
         if data.orderStatus == "0" || data.orderStatus == "1"{
             self.LblStatus.text  = "Placed"
            self.imgPlace.setImage(img: #imageLiteral(resourceName: "order accepted"))
         }else if data.orderStatus == "3" || data.orderStatus == "4"{
             self.LblStatus.text =  data.orderStatus == "3" ? "Preparing":"Ready for deliver"
             self.imgPlace.setImage(img: #imageLiteral(resourceName: "order accepted"))
            self.imgPreparing.setImage(img: #imageLiteral(resourceName: "preparating dish green"))
             //preparing
         }else if data.orderStatus == "5"{
             self.LblStatus.text  = "On the way"
              self.imgPlace.setImage(img: #imageLiteral(resourceName: "order accepted"))
            // self.lblPreparingTime.text  = data.preparing_time
              self.imgPreparing.setImage(img: #imageLiteral(resourceName: "preparating dish green"))
            self.imgOutForDelivery.setImage(img: #imageLiteral(resourceName: "out for delivery"))
         }
         else if data.orderStatus == "8"{
             self.LblStatus.text  = "Ready to Pickup"
              self.imgPlace.setImage(img: #imageLiteral(resourceName: "order accepted"))
            // self.lblPreparingTime.text  = data.preparing_time
              self.imgPreparing.setImage(img: #imageLiteral(resourceName: "preparating dish green"))
            self.imgOutForDelivery.setImage(img: #imageLiteral(resourceName: "out for delivery"))
         
         }else if data.orderStatus == "6"{
               self.LblStatus.text  = "Delivered"
            self.btnRepeatOrder.isHidden = false
             self.imgPlace.setImage(img: #imageLiteral(resourceName: "order accepted"))
             self.imgPreparing.setImage(img: #imageLiteral(resourceName: "preparating dish green"))
             self.imgOutForDelivery.setImage(img: #imageLiteral(resourceName: "out for delivery"))
            self.imgDelivered.setImage(img: #imageLiteral(resourceName: "devivered"))
         }else if data.orderStatus == "2"{
            self.LblStatus.text  = "REJECTED " + "(\(data.reject_reason.uppercased()))"
            self.btnReject.isEnabled = true

            self.rejectView.isHidden = false
        }

         if data.ratingdata.inChefId != nil{
//             self.rateView.isHidden = false
//             self.heightView.constant = 0
//             let ret = data.ratingdata.stFoodRating
//             let dsa = Double(ret ?? "0")
//             self.rateView.rating = dsa ?? 0
         }else{
            // self.rateView.isHidden = true
         }
        if data.orderStatus == "6"{
            heightTrackOrder.constant = 40
            self.lblOrderReadyText.isHidden = false
            self.heightReadyTxt.constant = 30

            
        }else{
          // heightTrackOrder.constant =
        }
        self.tableView.reloadData()
     }
    
    @IBAction func handleFulldetail(_ sender: Any) {
        Alert().OKAlertController(Message: self.items?.reject_reason.uppercased() ?? "", alertMsg:"ORDER REJECTED" )
    }
    
    @IBAction func handleCall(_ sender: Any) {
        if let url = NSURL(string: "tel://\(items?.chefdata.mobile ?? "")"), UIApplication.shared.canOpenURL(url as URL) {
            UIApplication.shared.open(url as! URL) { (result) in
                
            }
        }
    }
    
}
extension cell_ExpandedOderDetail : UITableViewDelegate ,UITableViewDataSource{
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
extension UIButton{
    func setImage(img:UIImage){
        self.setImage(img, for: .normal)
    }
}
