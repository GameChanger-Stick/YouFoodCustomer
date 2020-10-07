//
//  forgotPasswordViewController.swift
//  Zfood-User
//
//  Created by bhavya on 9/2/19.
//  Copyright © 2019 WemakeAppz. All rights reserved.
//

import UIKit
protocol GotoLoginViewWithOTP {
    func presentEnterOTPview(otp:String,email:String,phone:String)
}
class forgotPasswordViewController: UIViewController {

    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var viewMain: UIView!
    var delegate : GotoLoginViewWithOTP?
    override func viewDidLoad() {
        super.viewDidLoad()

    }
   
    @IBAction func handleReset(_ sender: Any) {
        if !(txtPhone.text!.isEmpty) || !(txtEmail.text!.isEmpty){
            self.sendOTP(email: txtEmail.text!
                , phone: txtPhone.text!)
        }else{
            self.showError(msg: "Enter your registered email/phone number")
        }
    }
    
    @IBAction func handleBack(_ sender: Any) {
        self.dismiss(animated: true, completion: {
        
        })
    }
    
    func sendOTP(email:String,phone:String){
        APIServices().sendOTP(email: email, phone: phone, viewController: self, loader: true) { (otp, error) in
            self.dismiss(animated: true, completion: {
                self.delegate?.presentEnterOTPview(otp: otp, email: email,phone: phone)
            })
        }
    }
    
}
extension forgotPasswordViewController : UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == txtEmail{
            txtPhone.text = ""
        }else{
            self.txtEmail.text = ""
        }
    }
}
