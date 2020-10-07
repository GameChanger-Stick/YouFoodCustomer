//
//  ChangePasswordViewController.swift
//  Zfood-User
//
//  Created by bhavya on 8/30/19.
//  Copyright © 2019 WemakeAppz. All rights reserved.
//

import UIKit

class ChangePasswordViewController: UIViewController {
    @IBOutlet weak var currentPassword: UITextField!
    
    @IBOutlet weak var txtNewPassword: UITextField!
    
    @IBOutlet weak var confirmNewPawword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func handleSubmit(_ sender: Any) {
        if currentPassword.text == ""{
            self.view.makeToast("Enter Current Password")
            return
        }
        if txtNewPassword.text == ""{
            self.view.makeToast("Enter New Password")
            return
        }
        if txtNewPassword.text != confirmNewPawword.text{
            self.view.makeToast("Confirm Password not match")
            return
        }
        self.changePassWord()
        
    }
    func changePassWord(){
        //current_pass=%@&new_password=%@
        let param = ["current_pass":self.currentPassword.text!,"new_password":self.txtNewPassword.text!,"user_id":currentUser?.info.inUserId ?? ""] as [String : Any]
              APIServices().ChangePass_API(params: param, viewController: self, loader: true) { (data, error) in
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    self.dismiss(animated: true, completion: nil)
                }

              }
             
              
          }
    @IBAction func handleback(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
