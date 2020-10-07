//
//  cardScreenVC.swift
//  Zfood-User
//
//  Created by bhavya on 1/3/20.
//  Copyright © 2020 WemakeAppz. All rights reserved.
//

import UIKit
import Stripe

class cardScreenVC: CommonViewController {

    @IBOutlet weak var txtCvv: UITextField!
    @IBOutlet weak var expDate: UITextField!
    @IBOutlet weak var txt4: UITextField!
    @IBOutlet weak var txt3: UITextField!
    @IBOutlet weak var txt2: UITextField!
    @IBOutlet weak var txt1: UITextField!
    
    @IBOutlet weak var txtName: UITextField!
    let stripeCardParams = STPCardParams()

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    func validateStrip(){
        if txtName.text == ""{
            alertResponse(message: "Enter Name")
            return
        }
        if txt1.text!.count != 16{
                    alertResponse(message: "Card Number invalid")
                   return
               }
        if expDate.text?.count != 5{
           
                alertResponse(message: "Expire Date invalid")
            return
        }
        if txtCvv.text!.count != 3{
             alertResponse(message: "CVV invalid")
            return
       
        }
        let mon = expDate.text?.components(separatedBy: "/")[0]
        let yer = expDate.text?.components(separatedBy: "/")[1]
        let expMonth = UInt(mon!.IntValue())
        let expYear = UInt(yer!.IntValue())
        stripeCardParams.number = self.txt1.text
        stripeCardParams.cvc = self.txtCvv.text
        stripeCardParams.expMonth = expMonth
                    stripeCardParams.expYear = expYear
            if STPCardValidator.validationState(forCard: stripeCardParams) == .valid{
               let config = STPPaymentConfiguration.shared()
                    let stpApiClient = STPAPIClient.init(configuration: config)
                    stpApiClient.createToken(withCard: stripeCardParams) { (token, error) in
                    if error == nil {
                    //Success
                    DispatchQueue.main.async {
                        if token != nil{
                            self.addCard(month: mon!, year: yer!, token: token?.tokenId ?? "", brand: STPCard.string(from: (token?.card!.brand)!))
                        }else{
                            self.alertResponse(message: "Token Failed")
                        }
                    }
                    }else{
                        self.alertResponse(message: error.debugDescription)
                        }
                        }
            }else{
               alertResponse(message: "Invalid Card")
            }
        }
    
    @IBAction func handeBack(_ sender: Any) {
         self.navigationController?.popViewController(animated: true)
    }
    @IBAction func handleAddCard(_ sender: Any) {
        validateStrip()
        
    }
    func addCard(month:String,year:String,token:String,brand:String){
        let last4 = String(self.txt1.text!.suffix(4))

        let dict = ["user_id":(currentUser?.info.inUserId)!,
                           "token":token,
                           "card_no":last4,"exp_date":year,
                           "exp_month":month,
                           "brand":brand,
                           "name":self.txtName.text
            ] as [String : Any]
               APIServices().AddCard(params:dict as! [String : String],loader:true , viewController: self) { (result) in
               
              self.view.makeToast("Card Added")
                
                self.navigationController?.popViewController(animated: true)
               }
    }
    //http://3.94.1.254/mobile/saveCard?card_no=4242&exp_date=12&exp_month=23&token=tok_visa&brand=visa&user_id=21
}
extension cardScreenVC : UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == txt1{
            let maxLength = 16
               let currentString: NSString = textField.text! as NSString
               let newString: NSString =
                   currentString.replacingCharacters(in: range, with: string) as NSString
               return newString.length <= maxLength
            
        }else if textField == expDate{
            if string != ""{
            if expDate.text!.count == 2{
                expDate.text =   expDate.text! + "/"
                }}
            let maxLength = 5
                          let currentString: NSString = textField.text! as NSString
                          let newString: NSString =
                              currentString.replacingCharacters(in: range, with: string) as NSString
                          return newString.length <= maxLength
            
        }else if textField == txtCvv{
            let maxLength = 3
                          let currentString: NSString = textField.text! as NSString
                          let newString: NSString =
                              currentString.replacingCharacters(in: range, with: string) as NSString
                          return newString.length <= maxLength
            
        }
        return true
    }
    
}
