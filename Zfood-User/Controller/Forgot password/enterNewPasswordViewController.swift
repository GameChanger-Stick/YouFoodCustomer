//
//  enterNewPasswordViewController.swift
//  Zfood-User
//
//  Created by bhavya on 9/2/19.
//  Copyright © 2019 WemakeAppz. All rights reserved.
//

import UIKit
protocol CHANGE_PASS_SUCCES {
    func ShowMsgForChangePass()
}
class enterNewPasswordViewController: UIViewController {
    
    @IBOutlet weak var txtNewPassword: UITextField!
    var email = String()
    var phone = String()
    @IBOutlet weak var txtConfirmPass: UITextField!
    var delegate : CHANGE_PASS_SUCCES?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func handleBack(_ sender: Any) {
        self.dismiss(animated: true) {
        }
    }
    
    @IBAction func handleConfirm(_ sender: Any) {
        if txtNewPassword.text!.isEmpty{
            self.showError(msg: "Enter password")
            return
        }
        if txtNewPassword.text == txtConfirmPass.text{
            self.resetPassword()
        }else{
              self.showError(msg: "Password not match")
        }
    }
    func resetPassword(){
        APIServices().resetOtp(email: self.email, phone: self.phone, password: self.txtNewPassword.text!, viewController: self, loader: true) { (successMsg, error) in
            self.dismiss(animated: true, completion: {
                 self.delegate?.ShowMsgForChangePass()
            })
           
        }
}
}
