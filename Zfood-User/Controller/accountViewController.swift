//
//  accountViewController.swift
//  Zfood-User
//
//  Created by bhavya on 1/10/20.
//  Copyright © 2020 WemakeAppz. All rights reserved.
//

import UIKit

class accountViewController: CommonViewController {

    
    @IBOutlet weak var imgV: UIImageView!
    @IBOutlet weak var bntBack: UIButton!
    @IBOutlet weak var lblNavTitle: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var viewSetting: UIView!
    @IBOutlet weak var viewAccount: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewSetting.alpha = 0.0
        self.viewAccount.alpha = 1
    }
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(true)
        getUserDetail()
       }
//MARK:- Button Action
   
    
    @IBAction func handleSupport(_ sender: Any) {
        gotoSupport()
    }
    @IBAction func handleTerms(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "aboutViewController") as! aboutViewController
                  let aObjNavi = UINavigationController(rootViewController: vc)
               vc.urlN = termsURL
               vc.titleN = "Terms & Conditions"
                  vc.navigationController?.navigationBar.isHidden = true
                  self.present(aObjNavi, animated: true) {
                  }
    }
    
    @IBAction func handleChangePassword(_ sender: Any) {
        gotoChangepassVC()
    }
    
    @IBAction func handleAboutUs(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "aboutViewController") as! aboutViewController
           let aObjNavi = UINavigationController(rootViewController: vc)
        vc.urlN = aboutusURL
        vc.titleN = "About Us"
           vc.navigationController?.navigationBar.isHidden = true
           self.present(aObjNavi, animated: true) {
           }

    }
    
    @IBAction func handleFQA(_ sender: Any) {
        gotoFAQ()
    }
    
    @IBAction func handleMyCards(_ sender: Any) {
        gotoPAymentScreen()
    }
    
    @IBAction func handleEditProfile(_ sender: UIButton) {
       gotoEditProfile()
    }
    
    @IBAction func handleSetting(_ sender: Any) {
        UIView.animate(withDuration: 0.2) {
            self.bntBack.setImage(#imageLiteral(resourceName: "Path-gry"), for: .normal)
            self.lblNavTitle.text = "SETTINGS"
            self.viewSetting.alpha = 1
            self.viewAccount.alpha = 0
            self.view.bringSubviewToFront(self.viewSetting)
            
        }
            }
    func gotoEditProfile(){
        let vc = storyboard?.instantiateViewController(withIdentifier: UIVIEWCONTROLLER_IDENTIFIRE.PROFILE) as! ZUCProfileViewController
           let aObjNavi = UINavigationController(rootViewController: vc)
           aObjNavi.modalPresentationStyle = .fullScreen
        vc.type = "1"
           vc.navigationController?.navigationBar.isHidden = true
           self.present(aObjNavi, animated: true) {
           }
    }
    func gotoSupport(){
             let vc = storyboard?.instantiateViewController(withIdentifier: "ZFUSupportVC") as! ZFUSupportVC
                       let aObjNavi = UINavigationController(rootViewController: vc)
                       aObjNavi.modalPresentationStyle = .overFullScreen
        aObjNavi.modalTransitionStyle = .coverVertical
                       vc.navigationController?.navigationBar.isHidden = true
                       self.present(aObjNavi, animated: true) {
                       }
         }
    @IBAction func backButtonDidTap(_ sender: UIButton) {
        if  self.viewAccount.alpha == 0{
            self.bntBack.setImage(#imageLiteral(resourceName: "Menu"), for: .normal)
            self.lblNavTitle.text = "ACCOUNT"
            self.viewSetting.alpha = 0
            self.viewAccount.alpha = 1
          return
        }
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        //    appDelegate.centerContainer?.toggle(MMDrawerSide.left, animated: true, completion: nil)
        appDelegate.drawerController.open(.left, animated: true, completion: nil)
    }
    
    @IBAction func handleReviews(_ sender: Any) {
        gotoReview()
    }
    @IBAction func handleMyorder(_ sender: Any) {
        gotoOrder()
    }
    
    //MARK:- Functions
    
    func getUserDetail(){
        self.lblName.text = self.userDetail?.firstName
        self.imgV.getImage(url: self.userDetail?.imgProfile ?? "")
    }
    func gotoPAymentScreen(){
    let vc = storyboard?.instantiateViewController(withIdentifier: UIVIEWCONTROLLER_IDENTIFIRE.PaymentVC) as! PaymentVC
    let aObjNavi = UINavigationController(rootViewController: vc)
    aObjNavi.modalPresentationStyle = .fullScreen
    vc.navigationController?.navigationBar.isHidden = true
    self.present(aObjNavi, animated: true) {
    }
    }
    func gotoFAQ(){
       let vc = storyboard?.instantiateViewController(withIdentifier: UIVIEWCONTROLLER_IDENTIFIRE.FAQViewController) as! FAQViewController
       let aObjNavi = UINavigationController(rootViewController: vc)
       aObjNavi.modalPresentationStyle = .fullScreen
       vc.navigationController?.navigationBar.isHidden = true
       self.present(aObjNavi, animated: true) {
       }
       }
    func gotoReview(){
        let vc = storyboard?.instantiateViewController(withIdentifier: UIVIEWCONTROLLER_IDENTIFIRE.reviewVC) as! ZFUReviewVC
        let aObjNavi = UINavigationController(rootViewController: vc)
        aObjNavi.modalPresentationStyle = .fullScreen
        vc.navigationController?.navigationBar.isHidden = true
        self.present(aObjNavi, animated: true) {
        }
        }
    func gotoOrder(){
    let vc = storyboard?.instantiateViewController(withIdentifier: UIVIEWCONTROLLER_IDENTIFIRE.ORDERS) as! ZFUOrdersVC
    let aObjNavi = UINavigationController(rootViewController: vc)
    aObjNavi.modalPresentationStyle = .fullScreen
        vc.fromMenu = false
    vc.navigationController?.navigationBar.isHidden = true
    self.present(aObjNavi, animated: true) {
    }
    }
    func gotoChangepassVC(){
         let vc = self.storyboard?.instantiateViewController(withIdentifier: "ChangePasswordViewController") as! ChangePasswordViewController
         //vc.delegate = self
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
    }

extension accountViewController : GotoLoginViewWithOTP,GOTO_NEWPASSWORD_VIEW,CHANGE_PASS_SUCCES{
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
