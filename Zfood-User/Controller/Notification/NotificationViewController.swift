//
//  NotificationViewController.swift
//  Zfood-User
//
//  Created by bhavya on 2/5/20.
//  Copyright © 2020 WemakeAppz. All rights reserved.
//

import UIKit
protocol DelegateGetNotificationList{
    func reloadNotificationApi()
}
//MARK:- Initial SetUP
extension NotificationViewController{
    
    func SetupViewData(){
        
        self.tableView.register(UINib(nibName: NotificationCell, bundle: nil), forCellReuseIdentifier: NotificationCell)
    }
}

class NotificationViewController: CommonViewController {
    //MARK:- OUTLETS
    var customerName = ""
    var delegate : DelegateDimVIEW?
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var lblNoNotification: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var delegateChefDetail : GotoChefDetailDelegate?
    //MARK:- Variable
    let  NotificationCell = "NotificationTableViewCell"
    var arrNotification : MODEL_NOTIFICATION?
    override func viewDidLoad() {
        super.viewDidLoad()
        SetupViewData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        CallNotificationAPI()
    }
    //MARK:- Button Action
    @IBAction func btnAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func handleAddAnouncement(_ sender: Any) {
          gotoAddAnouncement()
       }
    
    @IBAction func handleMsg(_ sender: Any) {
        gotoMsg()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        if self.delegate != nil{
            self.delegate?.hideDimView()
        }
    }
    //http://3.94.1.254/mobile/removenotification?to_id=ZCHEFB654QGB
    @IBAction func handleClearAll(_ sender: Any) {
        if self.arrNotification?.data.count != 0 && self.arrNotification != nil {
       
        Constants.alert.showActionSheet(title: "Delete all notifications", okTitle: "Confirm", cancelTitle: "Cancel", message: "", viewController: self, okAction: {
              self.DeleteNotificationAPI(id: "", chefId: "")
        }) {
            }}
        
    }
    
    //MARK:- functions
    func gotoAddAnouncement(){
        let chefDetailsVC = self.storyboard?.instantiateViewController(withIdentifier: "SendNoticeViewController")as! SendNoticeViewController
        chefDetailsVC.delegate = self
                             chefDetailsVC.modalPresentationStyle = .overFullScreen
                             self.present(chefDetailsVC, animated: false, completion: nil)
                   }

    func gotoMsg(){
        let chefDetailsVC = self.storyboard?.instantiateViewController(withIdentifier: "ChatViewController")as! ChatViewController
                             //chefDetailsVC.modalPresentationStyle = .overFullScreen
        let nav = UINavigationController(rootViewController: chefDetailsVC)
        nav.navigationBar.isHidden = true
        nav.modalPresentationStyle = .fullScreen
        
                             self.present(nav, animated: false, completion: nil)
                   }
    
}
extension NotificationViewController{
    //MARK:- API Functions
    func CallNotificationAPI(){
        //http://3.94.1.254/mobile/notificationlist?user_id=1
        let param = ["user_id":currentUser?.info.inUserId ?? ""] as [String : Any]
        APIServices().GetNotification(params: param, viewController: self, loader: true) { (data, error) in
            if data != nil{
                self.arrNotification = data
                self.lblNoNotification.isHidden = true
                self.tableView.reloadData()
            }else{
                self.arrNotification?.data.removeAll()
                               self.lblNoNotification.isHidden = false
                               self.tableView.reloadData()
            }
        }
    }
    
    func DeleteNotificationAPI(id : String,chefId:String){
        
        let param = ["user_id":currentUser?.info.inUserId ?? "","chef_id":chefId,"id":id] as [String : Any]
        APIServices().DeleteNotification(params: param, viewController: self, loader: true) { (data, error) in
            if data != nil{
                self.CallNotificationAPI()
            }
        }
    }
}

extension NotificationViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrNotification?.data.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NotificationCell, for: indexPath) as! NotificationTableViewCell
        cell.selectionStyle = .none
        let data = self.arrNotification?.data[indexPath.row]
        cell.addDataToCurrentCell(data: data ?? nil)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = self.arrNotification?.data[indexPath.row]
        if data?.type == "5"{//anouncement
            if self.delegateChefDetail != nil{
                self.dismiss(animated: true, completion: {
                     self.delegateChefDetail?.gotoChefDetail(id: self.arrNotification?.data[indexPath.row].chefId ?? "")
                })
            }
                        }else if data?.type == "4"{//reply
            createChat(detail: (self.arrNotification?.data[indexPath.row])!)
                        }else{//other
                        }
       
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            self.DeleteNotificationAPI(id: self.arrNotification?.data[indexPath.row].id ?? "", chefId: self.arrNotification?.data[indexPath.row].chefId ?? "" )
        }
    }
    
}
extension NotificationViewController{
    func createChat(detail:SingleNotificationModel){
        
        let customerName1 : String = detail.chefname
        let customerImg = detail.img
            self.customerName = customerName1
            let firstId = self.userDetail?.inUserId
         let SecondId = detail.chefId!
                    var FinalId : String = ""
                anotherUserId = SecondId
                FinalId = firstId! + "_" + SecondId
                print(FinalId)
                        UserTypeChat = "First"
                _ = String(format:"%.0f", NSDate().timeIntervalSince1970 * 1000)
                let currentUser = ["id":firstId ?? "","name":self.userDetail?.firstName,"online":true,"profile_image":self.userDetail?.imgProfile] as [String : Any]
                let otherUser = ["id":SecondId ?? "","name":self.customerName,"online":false,"profile_image":customerImg ?? "" ] as [String : Any]
                        let tempDict = [firstId:currentUser,SecondId:otherUser]
                        self.CreateChat(GroupID: FinalId, ChatData: tempDict as NSDictionary)
        }
    }
//}
extension NotificationViewController : DelegateGetNotificationList{
    func reloadNotificationApi() {
        CallNotificationAPI()
    }
    
    
}
