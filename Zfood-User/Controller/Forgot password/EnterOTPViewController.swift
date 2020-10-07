//
//  EnterOTPViewController.swift
//  Zfood-User
//
//  Created by bhavya on 9/2/19.
//  Copyright © 2019 WemakeAppz. All rights reserved.
//

import UIKit
protocol GOTO_NEWPASSWORD_VIEW {
    func presentNewPassword(email:String,phone:String)
}
class EnterOTPViewController: UIViewController {
    
    @IBOutlet weak var txtEnterOtp: UITextField!
    var otp = ""
    var email = ""
    var phone = ""
    var delegate : GOTO_NEWPASSWORD_VIEW?
    override func viewDidLoad() {
        super.viewDidLoad()
        print(otp)
    }
    
    @IBAction func handleBack(_ sender: Any) {
        self.dismiss(animated: true) {
        }
    }
    
    @IBAction func handleResetPass(_ sender: Any) {
        if otp == self.txtEnterOtp.text{
            self.dismiss(animated: true) {
                 self.delegate?.presentNewPassword(email: self.email, phone: self.phone)
            }
        }else{
            self.showError(msg: "Enter vaild OTP")
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
