//
//  SignupVC.swift
//  Zfood-User
//
//  Created by bhavya on 12/20/19.
//  Copyright © 2019 WemakeAppz. All rights reserved.
//

import UIKit
protocol OpenItemScreenDelegate {
    func gotoItemDetail()
}
class SignupVC: UIViewController {
    var presenter : RegisterPresenter?
    @IBOutlet weak var txtLastName: DynamicSizeTextField!
       @IBOutlet weak var txtfirstName: DynamicSizeTextField!
      // @IBOutlet var line2: UILabel!
      // @IBOutlet var line1: UILabel!
        //@IBOutlet var btnregister: UIButton!
    var delegate : OpenItemScreenDelegate?
       @IBOutlet weak var txtphoneRegister: DynamicSizeTextField!
       @IBOutlet weak var txtemailREgister: DynamicSizeTextField!
       @IBOutlet weak var txtPasswordRegister: DynamicSizeTextField!
       @IBOutlet weak var txtconfirmRegister: DynamicSizeTextField!
       @IBOutlet var viewRegister: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
 self.presenter = RegisterPresenter.init(delegate: self, viewcontroler: self)
        // Do any additional setup after loading the view.
    }

    @IBAction func handleSubmitRegister(_ sender: UIButton) {
     self.presenter?.register(firstName: self.txtfirstName.text!, lastNAme: txtLastName.text!, email: txtemailREgister.text!, password: txtPasswordRegister.text!, confirmPassword: txtconfirmRegister.text!, phone: txtphoneRegister.text!)
    }
    @IBAction func handleSignIn(_ sender: Any) {
        login()
    }
    
    
    func login(){
        self.dismiss(animated: false, completion: nil)
       
    }
    func gotoLocationVC(){
           let appDelegate = UIApplication.shared.delegate as! AppDelegate
                  appDelegate.setLocationViewController(forNoti: false)
       }
}
extension SignupVC : RegistrationDelegate{
    func didSucces() {
       NotificationCenter.default.post(name: NSNotification.Name(rawValue: "MenuUser"), object: nil)
                if self.delegate != nil{
                    self.dismiss(animated: true) {
                         self.delegate?.gotoItemDetail()
                    }
                   
                }
             else{
                 gotoLocationVC()
                 print("Success")
             }
    }
    
    func didFailWithError(error: String) {
       self.showError(msg: error)
    }
}
