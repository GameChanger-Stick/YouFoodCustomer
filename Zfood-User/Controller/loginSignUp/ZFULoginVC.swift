//  ZFULoginVC.swift
//  Zfood-User
//  Created by Mukesh on 19/07/19.
//  Copyright © 2019 WemakeAppz. All rights reserved.

import UIKit
import SCLAlertView
var loginToken = ""
var userIDHeadder = ""
var isguest = false
class ZFULoginVC: UIViewController {
    var presenter : RegisterPresenter?
    @IBOutlet var viewSignIn: UIView!
    @IBOutlet var btnsignin: UIButton!
    var fromGuestUser = Bool()
    @IBOutlet var txtemailLogin: UITextField!
    @IBOutlet var txtpasswordLogin: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = RegisterPresenter.init(delegate: self, viewcontroler: self)
    }
    
    @IBAction func handleRegister(_ sender: Any) {
         isguest = false
        goToresgisterTab()
    }
    
    @IBAction func handleBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func btnsignin(_ sender: Any) {
         isguest = false
        self.presenter?.login(email: self.txtemailLogin.text!, password: self.txtpasswordLogin.text!)
    }
    
    @IBAction func handleGuest(_ sender: Any) {
        isguest = true
        self.gotoLocationVC()
    }
    
    @IBAction func handleForgotPassword(_ sender: Any) {
        gotoForgotpassVC()
    }
    
    func gotoForgotpassVC(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "forgotPasswordViewController") as! forgotPasswordViewController
        vc.delegate = self
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: false, completion: nil)
    }
   
    func gotoEnterOtpVC(otp:String,email:String,phone:String){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "EnterOTPViewController") as! EnterOTPViewController
        vc.delegate = self
        vc.otp = otp
        vc.phone = phone
        vc.email = email
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: false, completion: nil)
    }
    func gotoNewPassVC(email:String,phone:String){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "enterNewPasswordViewController") as! enterNewPasswordViewController
        vc.delegate = self
        vc.email = email
        vc.phone = phone
         vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: false, completion: nil)
    }
    
    
    @IBAction func handleSecurreEntry(_ sender: Any) {
        if txtpasswordLogin.isSecureTextEntry{
            self.txtpasswordLogin.isSecureTextEntry = false
        }else{
            self.txtpasswordLogin.isSecureTextEntry = true

        }
    }
    func goToresgisterTab(){
       let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignupVC") as! SignupVC
        if fromGuestUser{
            vc.delegate = self
        }
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false, completion: nil)
    }
    func gotoLocationVC(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.setLocationViewController(forNoti: false)
}
}

extension ZFULoginVC : GotoLoginViewWithOTP,GOTO_NEWPASSWORD_VIEW,CHANGE_PASS_SUCCES{
    func ShowMsgForChangePass() {
   self.showSuccess(msg:"Password Changed")
    }
    
    func presentNewPassword(email: String, phone: String) {
        gotoNewPassVC(email: email, phone: phone)
    }
    
    func presentEnterOTPview(otp: String, email: String, phone: String) {
        self.gotoEnterOtpVC(otp: otp, email: email, phone: phone)
    }
   
}

extension ZFULoginVC : RegistrationDelegate{
    func didSucces() {
         NotificationCenter.default.post(name: NSNotification.Name(rawValue: "MenuUser"), object: nil)
        if fromGuestUser{
            self.dismiss(animated: true, completion: nil)
        }else{
            gotoLocationVC()
            print("Success")
        }
        
    }
    
    func didFailWithError(error: String) {
        self.removeFromParent()
       self.showError(msg: error)
    }
}
extension ZFULoginVC : OpenItemScreenDelegate{
    func gotoItemDetail() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
