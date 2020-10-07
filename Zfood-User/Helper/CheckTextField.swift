//
//  CheckTextField.swift
//  EatDiggerCustomer
//
//  Created by Jaypreet on 14/06/18.
//  Copyright © 2018 Ramneet Singh. All rights reserved.
//

import Foundation

class CheckTextField: NSObject {
    
    func CheckEmail(text : String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        if emailTest.evaluate(with: text) == false{
            return false
        }
        return emailTest.evaluate(with: text)
    }
    func CheckPassword(text : String) -> Bool {
        if text.contains(" "){
            Constants.Toast.MyToast(message: Constants.MESSAGE.EMPTY_Password_With_Space, image: Constants.AppLogo)

            return false
        }
        if text.count < 6{
            Constants.Toast.MyToast(message: Constants.MESSAGE.EMPTY_Password, image: Constants.AppLogo)
            return false

        }
        
        return true
    }
    func MatchPassword(text1 : String , text2 : String) -> Bool {
        if text1 != text2{
              Constants.Toast.MyToast(message: Constants.MESSAGE.EMPTY_Password_match, image: Constants.AppLogo)
            return false
        }
        return true
        
    }
    func CheckSimpleTextField(text : String) -> Bool {
        if text.count == 0{
              Constants.Toast.MyToast(message: Constants.MESSAGE.EMPTY_Field, image: Constants.AppLogo)
            return false
        }
        return true
    }
 
    func CheckCountryCodeTextField(text : String) -> Bool {
        if text.count == 0{
              Constants.Toast.MyToast(message: Constants.MESSAGE.EMPTY_Country_Code_Field, image: Constants.AppLogo)
            
            return false
        }
        return true
    }
    func CheckPhoneNumber(text : String) -> Bool {
        if text.count < 9{
              Constants.Toast.MyToast(message: Constants.MESSAGE.EMPTY_Phone, image: Constants.AppLogo)
            
            return false
        }
        return true
    }
    func CheckCountryCode(text : String) -> Bool {
        if text.count == 0 || !text.contains("+"){
              Constants.Toast.MyToast(message: Constants.MESSAGE.EMPTY_Phone, image: Constants.AppLogo)
            
            return false
        }
        return true
    }
    func CheckTermsAndConditions(isChecked : Bool) -> Bool {
        if isChecked != true{
              Constants.Toast.MyToast(message: Constants.MESSAGE.CheckTermAndConditon, image: Constants.AppLogo)
            return false
        }
        return true
    }
    func CheckOTP(text : String , count : Int) -> Bool {
        if text.count != count{
              Constants.Toast.MyToast(message: Constants.MESSAGE.EMPTY_Otp, image: Constants.AppLogo)
            return false
        }
        return true
    }
}
