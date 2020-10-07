//
//  OrderStatusDetailViewController.swift
//  Zfood-User
//
//  Created by bhavya on 1/14/20.
//  Copyright © 2020 WemakeAppz. All rights reserved.

import UIKit

class OrderStatusDetailViewController: UIViewController {

    @IBOutlet weak var lblOrder_ID: UILabel!
    @IBOutlet weak var lblTaxCharges: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblDistance: UILabel!
    @IBOutlet weak var lblOrderID: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblOrderType: UILabel!
    @IBOutlet weak var lblDeliveryAddress: UILabel!
    @IBOutlet weak var lblPhone: UILabel!
    @IBOutlet weak var lblPaymentUsing: UILabel!
    @IBOutlet weak var lblOrderID1: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    
    @IBOutlet weak var lblCreditDelivery: UILabel!
    @IBOutlet weak var heightTableView: NSLayoutConstraint!
    var orderDetail : Order?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "cell_itemConfirm", bundle: nil), forCellReuseIdentifier: "cell_itemConfirm")
        if orderDetail != nil{
            addData()
            self.heightTableView.constant = CGFloat(self.orderDetail!.orderDetail.count * 30)
            self.tableView.reloadData()
        }
    }
//MARK:- BUTTON ACTION
    @IBAction func handleBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    func call(phoneNumber: String) {
        if let url = URL(string: "tel://\(phoneNumber)") {
                UIApplication.shared.open(url, options: [:],
                                          completionHandler: {
                                            (success) in
                                            print("Open \(phoneNumber): \(success)")
                })
        }
    }
    
    @IBAction func handeContact(_ sender: UIButton) {
        call(phoneNumber: orderDetail?.chefdata.mobile ?? "")
    }
    
    func addData(){
        self.lblName.text = orderDetail?.chefdata.stRestaurantName ?? ""
        self.lblOrderID.text = "ORDER ID: " + (orderDetail?.orderNumber ?? "")
        self.lblOrder_ID.text = "ORDER ID: " + (orderDetail?.orderNumber ?? "")
         let flotdeliveryCharge = Double(orderDetail?.deliveryCharge ?? "0")
        let doubeCreditcardFee = Double(orderDetail?.creditCardFee ?? "0")
        let totalCharge = flotdeliveryCharge! + doubeCreditcardFee!
        if orderDetail?.orderType == "1"{
            self.lblCreditDelivery.text = "Service fee:\nDelivery Charge:"
                   self.lblTaxCharges.text = "$\(orderDetail?.creditCardFee ?? "0")\n$\(orderDetail?.deliveryCharge ?? "0")" //"$" + String(format:"%.2f", totalCharge)
        }else{
            self.lblCreditDelivery.text = "Service fee:"
                   self.lblTaxCharges.text = "$\(orderDetail?.creditCardFee ?? "0")" //"$" + String(format:"%.2f", totalCharge)
        }
        self.lblOrderID1.text = "ORDER ID: " + (orderDetail?.orderNumber ?? "")
        self.lblPhone.text = "Phone Number: " + (orderDetail?.chefdata.mobile ?? "")
        self.lblPaymentUsing.text = "Payment Using: " + (orderDetail?.paymentMethod ?? "")
        self.lblTime.text = "Time: " + (orderDetail?.orderDate ?? "")
        self.lblPrice.text = orderDetail?.totalAmount ?? ""
        self.lblDistance.text = "Distance: " + (orderDetail?.distance ?? "-") + " mi"
    }
    
}
extension OrderStatusDetailViewController : UITableViewDelegate ,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderDetail?.orderDetail.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell_itemConfirm", for: indexPath) as! cell_itemConfirm
        cell.addDataOrder(cart: (orderDetail?.orderDetail[indexPath.row] ?? nil))
        cell.selectionStyle = .none
        return cell
    }
    
    
}
