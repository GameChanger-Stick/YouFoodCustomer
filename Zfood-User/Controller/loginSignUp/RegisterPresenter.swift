
import Foundation
protocol RegistrationDelegate {
    func didSucces()
    func didFailWithError(error:String)
}

class RegisterPresenter{
    var delegate : RegistrationDelegate
    var viewcontroller : UIViewController
    init(delegate:RegistrationDelegate,viewcontroler:UIViewController) {
        self.delegate = delegate
        self.viewcontroller = viewcontroler
    }
    
    func register(firstName:String,lastNAme:String,email:String,password:String,confirmPassword:String,phone:String){
        if firstName.isEmpty{
            self.delegate.didFailWithError(error: Constants.MESSAGE.EMPTY_FIRSTNAME)
            return
        }
        if lastNAme.isEmpty{
            self.delegate.didFailWithError(error: Constants.MESSAGE.EMPTY_LASTNAME)
            return
        }
//        if email.isEmpty{
//            self.delegate.didFailWithError(error: Constants.MESSAGE.EMPTY_Email)
//            return
//        }
        if phone.isEmpty{
                   self.delegate.didFailWithError(error: Constants.MESSAGE.EMPTY_Phone)
                   return
               }
               if phone.count <= 6{
                   self.delegate.didFailWithError(error: Constants.MESSAGE.EMPTY_Phone)
                   return
               }
        if !(Constants.checkTextField.CheckEmail(text: email)){
            self.delegate.didFailWithError(error: Constants.MESSAGE.EMPTY_Email)
            return
        }
        if password.isEmpty{
            self.delegate.didFailWithError(error: Constants.MESSAGE.EMPTY_Password)
            return
        }
        if password.count <= 5{
            self.delegate.didFailWithError(error: Constants.MESSAGE.EMPTY_Password)
            return
        }
        if confirmPassword.isEmpty{
            self.delegate.didFailWithError(error: Constants.MESSAGE.EMPTY_CONFIRMPASS)
            return
        }
        if password != confirmPassword{
            self.delegate.didFailWithError(error: Constants.MESSAGE.EMPTY_Password_match)
            return
        }
       
        
        let dict = ["email":email,"device_type":"iOS","firstname":firstName,"lastname":lastNAme,"password":password,"device_token":MydeviceToken,"mobile":phone]
        APIServices().REGISTER_USER(params: dict, viewController: viewcontroller, loader: true) { (result, errors) in
            if result != nil{
                if result?.status == "1"{
                    self.delegate.didSucces()
                }else{
                    self.delegate.didFailWithError(error: result?.msg ?? "server down")
                }
            }else{
                 self.delegate.didFailWithError(error: "FAILED")
            }
        }
    }
    
    func editProfile(firstName:String,lastNAme:String,email:String,phone:String,img:String,lnt:String,lng:String,Profile_Address:String){
        if firstName.isEmpty{
            self.delegate.didFailWithError(error: Constants.MESSAGE.EMPTY_FIRSTNAME)
            return
        }
        if lastNAme.isEmpty{
            self.delegate.didFailWithError(error: Constants.MESSAGE.EMPTY_LASTNAME)
            return
        }
        if email.isEmpty{
            self.delegate.didFailWithError(error: Constants.MESSAGE.EMPTY_Email)
            return
        }
        if !(Constants.checkTextField.CheckEmail(text: email)){
            self.delegate.didFailWithError(error: Constants.MESSAGE.EMPTY_Email)
            return
        }
       
        if phone.isEmpty{
            self.delegate.didFailWithError(error: Constants.MESSAGE.EMPTY_Phone)
            return
        }
        if phone.count <= 6{
            self.delegate.didFailWithError(error: Constants.MESSAGE.EMPTY_Phone)
            return
        }
        
        let dict = ["email":email,"device_type":"iOS_","firstname":firstName,"lastname":lastNAme,"device_token":MydeviceToken,"mobile":phone,"user_id":currentUser?.info.inUserId,"profile_picture":img,"profile_address":Profile_Address,"lat":lnt,"lng":lng] as! [String:String]
        APIServices().EDIT_USER(params: dict, viewController: viewcontroller, loader: true) { (result, errors) in
            if result != nil{
                if result?.status == "1"{
                    self.delegate.didSucces()
                }else{
                    self.delegate.didFailWithError(error: result?.msg ?? "server down")
                }
            }else{
                self.delegate.didFailWithError(error: "FAILED")
            }
        }
    }

    func login(email:String,password:String){
        if email.isEmpty{
            self.delegate.didFailWithError(error: Constants.MESSAGE.EMPTY_Email)
            return
        }
        if password.isEmpty{
            self.delegate.didFailWithError(error: Constants.MESSAGE.EMPTY_Password)
            return
        }
        if password.count <= 5{
            self.delegate.didFailWithError(error: Constants.MESSAGE.EMPTY_Password)
            return
        }
        if !(Constants.checkTextField.CheckEmail(text: email)){
            self.delegate.didFailWithError(error: Constants.MESSAGE.INVALID_EMAIL)
            return
        }
        let dict = ["email":email,"password":password,"device_type":"iOS","device_token":MydeviceToken]
        APIServices().LOGIN_USER(params: dict,viewController:self.viewcontroller, loader: true) { (result, errors) in
            if result == nil{
                self.delegate.didFailWithError(error: "No network")
            }
            if result?.status == "1"{
                self.delegate.didSucces()
            }else{
                self.delegate.didFailWithError(error: result?.msg ?? "Server Down")
            }
        }
        
    }
}
