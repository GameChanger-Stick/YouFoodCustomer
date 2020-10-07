//
//  ZFUOrdersVC.swift
//  Zfood-User
//  Created by apple on 06/05/19.
//  Copyright © 2019 WemakeAppz. All rights reserved.

import UIKit
import NotificationCenter

class ZFUOrdersVC: CommonViewController {
    var myOrder : Model_MyOrder?
    var fromMenu = true
    var fromSetting = false
    var yearListarr = [Int]()
    
    @IBOutlet weak var lblNoOrder: UILabel!
    @IBOutlet var tableview: UITableView!
    var refreshControl = UIRefreshControl()
    @IBOutlet weak var btnBack: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
      tableview.register(UINib(nibName: "cell_orderList", bundle: nil), forCellReuseIdentifier: "cell_orderList")
        tableview.register(UINib(nibName: "cell_ExpandedOderDetail", bundle: nil), forCellReuseIdentifier: "cell_ExpandedOderDetail")
        pulToRefresh()
        yearList(loader: false)
        self.lblNoOrder.isHidden = true
        NotificationCenter.default.addObserver(self, selector: #selector(reloadORderList), name: NSNotification.Name(rawValue: NotificationCenter.reloadOrderList), object: nil)
    }
    @objc func reloadORderList(){
        MYOrderList(loader:false, year: "", type: "")
    }
    func cornerRadius(image:UIImageView,radius:Double){
        image.cornerRadius = CGFloat(radius/2)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
        MYOrderList(loader:true, year: "", type: "")
    }
    
    func pulToRefresh(){
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(sender:)), for: UIControl.Event.valueChanged)
        tableview.addSubview(refreshControl)
    }
    
    @objc func gotoToOrderDetail(sender:UIButton){
        if #available(iOS 13.0, *) {
            let vc = self.storyboard?.instantiateViewController(identifier: "OrderStatusDetailViewController") as! OrderStatusDetailViewController
            vc.orderDetail = self.myOrder?.order[sender.tag]
                  self.present(vc, animated: true) {}
        } else {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "OrderStatusDetailViewController") as! OrderStatusDetailViewController
            vc.orderDetail = self.myOrder?.order[sender.tag]
            self.present(vc, animated: true) {}
        }
    }
    
    @objc func gotoToCartScreen(sender:UIButton){
           if #available(iOS 13.0, *) {
               let vc = self.storyboard?.instantiateViewController(identifier: "ZFUCartVC") as! ZFUCartVC
            vc.modalPresentationStyle = .fullScreen
            vc.fromOrderScreen = true
            vc.orderID = self.myOrder?.order[sender.tag].id
                     self.present(vc, animated: true) {}
           } else {
               let vc = self.storyboard?.instantiateViewController(withIdentifier: "ZFUCartVC") as! ZFUCartVC
             vc.modalPresentationStyle = .fullScreen
            vc.fromOrderScreen = true
                        vc.orderID = self.myOrder?.order[sender.tag].id
               self.present(vc, animated: true) {}
               // Fallback on earlier versions
           }
       }
   func gotoToFilter(){
              if #available(iOS 13.0, *) {
                  let vc = self.storyboard?.instantiateViewController(identifier: "FilterViewController") as! FilterViewController
               vc.modalPresentationStyle = .overFullScreen
                 vc.dalegate = self
                let arr = self.yearListarr.map{String($0)}
                vc.arrYears = arr
                let nav = UINavigationController(rootViewController: vc)
                nav.modalPresentationStyle = .overFullScreen
                nav.navigationBar.isHidden = true
              // vc.fromOrderScreen = true
              // vc.orderID = self.myOrder?.order[sender.tag].id
                self.present(nav, animated: false, completion: nil)
                                } else {
                  let vc = self.storyboard?.instantiateViewController(withIdentifier: "FilterViewController") as! FilterViewController
                vc.dalegate = self
                 let arr = self.yearListarr.map{String($0)}
                vc.arrYears = arr
                vc.modalPresentationStyle = .overFullScreen
                let nav = UINavigationController(rootViewController: vc)
                               nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: false, completion: nil)
              }
          }
    @objc func refresh(sender:AnyObject) {
        MYOrderList(loader:false, year: "", type: "")
        refreshControl.endRefreshing()
    }
    @objc func gotoRateVC(index:Int){
        if let vc3 = self.storyboard?.instantiateViewController(withIdentifier: UIVIEWCONTROLLER_IDENTIFIRE.RATEVC) as? RateViewController {
            let dataOrder = self.myOrder?.order[index]
            vc3.ordeDAta = dataOrder
            vc3.delegate = self
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController!.present(vc3, animated: false, completion: nil)
        }
    }
   @objc func handleRate(sender:UIButton){
    gotoRateVC(index:sender.tag)
    }
   
    override func viewDidDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
        self.setupStatusBarColor(isEnable: true)

    }
    @IBAction func backButtonDidTap(_ sender: UIButton) {
        if fromMenu{
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
                   appDelegate.drawerController.open(.left, animated: true, completion: nil)
        }else{
            self.dismiss(animated: true, completion: nil)
        }
    }

    @IBAction func handleFilter(_ sender: Any) {
        addAlert(type: "")
    }
    func MYOrderList(loader:Bool,year:String,type:String){
        let dict = ["userid":(currentUser?.info.inUserId) ?? "","year":year,"type":type]
        APIServices().MY_ORDER(params:dict ,loader:loader , viewController: self) { (result) in
            
            self.myOrder?.order.removeAll()
                self.myOrder = result
                self.tableview.reloadData()
            if self.myOrder?.order.count == 0{
                self.lblNoOrder.isHidden = false
            }else{
                self.lblNoOrder.isHidden = true
            }
        }
    }
    func yearList(loader:Bool){
        let dict = ["userid":(currentUser?.info.inUserId)!]
        APIServices().YearList(params:dict ,loader:loader , viewController: self) { (result) in
            self.yearListarr = result?.value(forKey: "data") as! [Int]
        }
    }
    func tableViewExpand(){
        
    }
    func addAlert(type:String){
        let alertcontroller = UIAlertController(title: "Apply Filter", message: "", preferredStyle: .alert)
        let action1 = UIAlertAction(title: "Last 7 days", style: .default) { (result) in
            //print
            self.MYOrderList(loader:true, year: "", type: "1")
        }
        let action3 = UIAlertAction(title: "This Month", style: .default) { (result) in
            //print
            self.MYOrderList(loader:true, year: "", type: "2")
        }
        let action4 = UIAlertAction(title: "Last Month", style: .default) { (result) in
            //print
            self.MYOrderList(loader:true, year: "", type: "3")
        }
        let action5 = UIAlertAction(title: "Last 6 Month", style: .default) { (result) in
            //print
            self.MYOrderList(loader:true, year: "", type: "4")
        }
        let action6 = UIAlertAction(title: "Select Year", style: .default) { (result) in
            //print
            self.gotoToFilter()
        }
        let action7 = UIAlertAction(title: "Reset", style: .default) { (result) in
            //print
            self.MYOrderList(loader:true, year: "", type: "")
        }
        let action8 = UIAlertAction(title: "Cancel", style: .cancel) { (result) in
            //print
        }
        alertcontroller.addAction(action1)
         alertcontroller.addAction(action3)
         alertcontroller.addAction(action4)
         alertcontroller.addAction(action5)
         alertcontroller.addAction(action6)
 alertcontroller.addAction(action7)
         alertcontroller.addAction(action8)
        self.present(alertcontroller, animated: true) {
        }
    }
    //YearList
}
extension ZFUOrdersVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.myOrder?.order.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (self.myOrder?.order[indexPath.row].isOpen)!{
        let cell = tableview.dequeueReusableCell(withIdentifier: "cell_ExpandedOderDetail", for: indexPath) as! cell_ExpandedOderDetail
        cell.selectionStyle = .none
 cell.btnRepeatOrder.tag = indexPath.row
                      cell.btnRepeatOrder.addTarget(self, action: #selector(self.gotoToCartScreen(sender:)), for: .touchUpInside)
            let dataOrder = self.myOrder?.order[indexPath.row]
            cell.btnRateYourOrder.tag = indexPath.row
            cell.btnRateYourOrder.addTarget(self, action: #selector(self.handleRate(sender:)), for: .touchUpInside)
            cell.addData(data: dataOrder!)
    cell.items = dataOrder
        return cell
        }else{
            let cell = tableview.dequeueReusableCell(withIdentifier: "cell_orderList", for: indexPath) as! cell_orderList
            cell.selectionStyle = .none
            let dataOrder = self.myOrder?.order[indexPath.row]
           
            cell.btnOrderStatus.tag = indexPath.row
            cell.btnViewOrder.tag = indexPath.row
            cell.btnViewOrder.addTarget(self, action: #selector(self.gotoToOrderDetail(sender:)), for: .touchUpInside)
            cell.addData(data: dataOrder!)
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          if (self.myOrder?.order[indexPath.row].isOpen)!{
            self.myOrder?.order[indexPath.row].isOpen = false
            self.tableview.reloadData()
          }else{
             self.myOrder?.order[indexPath.row].isOpen = true
              self.tableview.reloadData()
            let indexPath = NSIndexPath(item: indexPath.row, section: indexPath.section)
            tableView.scrollToRow(at: indexPath as IndexPath, at: UITableView.ScrollPosition.middle, animated: true)
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
extension ZFUOrdersVC : RELOADORDER,filterYearDelegate{
    func applyFilter(year: String, type: String) {
        MYOrderList(loader: true, year: year, type: type)
    }
    
    
    func reloadORDER() {
        MYOrderList(loader: false, year: "", type: "")
    }
    
    
}
