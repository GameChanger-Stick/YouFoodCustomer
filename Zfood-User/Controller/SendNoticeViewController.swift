//
//  SendNoticeViewController.swift
//  Zfood-User
//
//  Created by bhavya on 2/5/20.
//  Copyright © 2020 WemakeAppz. All rights reserved.
//

import UIKit

class SendNoticeViewController: UIViewController {

    @IBOutlet weak var btnConfirm: UIButton!
    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var txtDiscription: UITextField!
    var delegate : DelegateGetNotificationList?
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func handleConfirm(_ sender: Any) {
        if txtTitle.text == ""{
             self.alert("Error", message: "Enter title")
        } else if txtDiscription.text == ""{
           self.alert("Error", message: "Enter Description")
        }else{
             ADDNotification_API()
        }
    }
    
    @IBAction func handleCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
extension SendNoticeViewController {
    //MARK:- API Functions
    func ADDNotification_API(){
        //http://3.94.1.254/mobile/addNotificaton?title=title&description=desc&type=3
        self.btnConfirm.isEnabled = false
        let param = ["title":self.txtTitle.text!,"description":txtDiscription.text!,"user_id":currentUser?.info.inUserId ?? "","type":"3"] as [String : Any]
        APIServices().AddNotification(params: param, viewController: self, loader: true) { (data, error) in
            self.btnConfirm.isEnabled = true
            if data != nil{
                self.showSuccessWithBtn(msg: data!.msg) {
                    self.dismiss(animated: false) {
                        self.delegate?.reloadNotificationApi()
                    }
                }

            }
        }
        
    }
}
