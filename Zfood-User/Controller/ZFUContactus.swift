//
//  ZFUContactus.swift
//  Zfood-User
//
//  Created by Mukesh on 30/07/19.
//  Copyright © 2019 WemakeAppz. All rights reserved.
//

import UIKit

class ZFUContactus: UIViewController {

    @IBOutlet weak var txtmessage: DynamicSizeTextField!
    @IBOutlet weak var txtEmail: DynamicSizeTextField!
    @IBOutlet weak var txtname: DynamicSizeTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
self.txtname.text = currentUser?.info.firstName
        self.txtEmail.text = currentUser?.info.userEmail
        // Do any additional setup after loading the view.
    }
    
    @IBAction func handleMenu(_ sender: Any) {
        
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            //    appDelegate.centerContainer?.toggle(MMDrawerSide.left, animated: true, completion: nil)
            appDelegate.drawerController.open(.left, animated: true, completion: nil)
        
    }

    @IBAction func handleSAEnd(_ sender: Any) {
        if txtmessage.text != ""{
           sendAPI()
        }else{
            self.showError(msg: "Enter message")
        }
    }
    
    func sendAPI(){
        let dict = ["user_id":currentUser!.info.inUserId!,"name":txtname.text!,"email":txtEmail.text!,"message":txtmessage.text!] as [String : Any]
       
        APIServices().supportAPI(params: dict, viewController: self, loader: true) {
            self.txtmessage.text = ""
        }
    }
}
