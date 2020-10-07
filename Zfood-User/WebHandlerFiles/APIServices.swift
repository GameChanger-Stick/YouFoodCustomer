//  APIServices.swift
//  Zfood-User
//  Created by bhavya on 8/26/19.
//  Copyright © 2019 WemakeAppz. All rights reserved.

import Foundation
class APIServices :NSObject {
    
    func LOGIN_USER(params : [String:Any], viewController:UIViewController,loader:Bool, completion: @escaping (_ result: ModelUser?, _ error: String)->()){
        HTTPHelper().httpGetResponse(strURL: Login_URL, params: params, view: viewController,loader:loader) { (result, errors) in
            if result == nil{
                completion(nil,"")
                return
            }
            let data = ModelUser.init(fromDictionary: result as! [String : Any])
            if data.status == "1"{
                loginToken = (result as! NSDictionary).value(forKey: "token") as! String
                 UserDefaults.standard.set(loginToken, forKey: Constants.userDefaults.usrToken)
                UserDefaults.standard.set(result, forKey: Constants.userDefaults.userDetail)
                currentUser = ModelUser.init(fromDictionary: result as! [String : Any])
            }
             
           completion(data,"")
        }
    }
    
    func GET_USER(params : [String:Any], viewController:UIViewController,loader:Bool, completion: @escaping (_ result: ModelUser?, _ error: String)->()){
        HTTPHelper().httpGetResponse(strURL: getProfile, params: params, view: viewController,loader:loader) { (result, errors) in
            if result == nil{
                completion(nil,"")
                return
            }
            let data = ModelUser.init(fromDictionary: result as! [String : Any])
            if data.status == "1"{
                UserDefaults.standard.set(result, forKey: Constants.userDefaults.userDetail)
            }
            completion(data,"")
        }
    }
    
       func Logout(params : [String:Any], viewController:UIViewController,loader:Bool, completion: @escaping (_ result: GernalModel?, _ error: String)->()){
           HTTPHelper().httpGetResponse(strURL: POST_Logout, params: params, view: viewController,loader:loader) { (result, errors) in
               if result == nil{
                   completion(nil,"")
                   return
               }
             let data = GernalModel.init(fromDictionary: result as! [String : Any])
               if data.status == "1"{
                GloAddress1 = ""
                                  GloLng = ""
                                  GloLat = ""
                userLAT = 0.0
                userLNG = 0.0
                currentUser = nil
                UserDefaults.standard.removeObject(forKey: Constants.userDefaults.usrToken)
               }
               completion(data,"")
           }
       }
    
    func REGISTER_USER(params : [String:Any], viewController:UIViewController,loader:Bool, completion: @escaping (_ result: ModelUser?, _ error: String)->()){
        HTTPHelper().httpGetResponse(strURL: REGISTER_URL, params: params, view: viewController,loader:loader) { (result, errors) in
            if result == nil{
                completion(nil,"")
                return
            }
            let data = ModelUser.init(fromDictionary: result as! [String : Any])
            if data.status == "1"{
                loginToken = (result as! NSDictionary).value(forKey: "token") as? String ?? ""
                UserDefaults.standard.set(loginToken, forKey: Constants.userDefaults.usrToken)
                UserDefaults.standard.set(result, forKey: Constants.userDefaults.userDetail)
                currentUser = ModelUser.init(fromDictionary: result as! [String : Any])
            }
            completion(data,"")
        }
    }
    
    
    func EDIT_USER(params : [String:Any], viewController:UIViewController,loader:Bool, completion: @escaping (_ result: ModelUser?, _ error: String)->()){
        HTTPHelper().httpGetResponse(strURL: EDIT_USER_URL, params: params, view: viewController,loader:loader) { (result, errors) in
            if result == nil{
                completion(nil,"")
                return
            }
            let data = ModelUser.init(fromDictionary: result as! [String : Any])
            if data.status == "1"{
                UserDefaults.standard.set(result, forKey: Constants.userDefaults.userDetail)
                currentUser = ModelUser.init(fromDictionary: UserDefaults.standard.value(forKey: Constants.userDefaults.userDetail) as! [String:Any])
            }
            completion(data,"")
        }
    }
    
    func sendOTP(email : String,phone:String, viewController:UIViewController,loader:Bool, completion: @escaping (_ otp: String, _ error: String)->()){
        var newUrl = String()
        if phone.isEmpty{
            newUrl = "\(SEND_OTP)?email=\(email)"
        }else{
             newUrl = "\(SEND_OTP)?phone=\(phone)"
        }
        HTTPHelper().httpGetResponse(strURL: newUrl, params: nil, view: viewController,loader:loader) { (result, errors) in
            if result == nil{
                return
            }
            if (result as! NSDictionary).value(forKey: "status") as! String == "0"{
                viewController.showErrorGreen(msg: (result as! NSDictionary).value(forKey: "msg") as! String)
            }else{
                completion((result as! NSDictionary).value(forKey: "otp") as! String,"")
            }
        }
    }

    func resetOtp(email : String,phone:String,password:String, viewController:UIViewController,loader:Bool, completion: @escaping (_ otp: String, _ error: String)->()){
        var newUrl = String()
        if phone.isEmpty{
            newUrl = "\(RESET_PASSWORD)?email=\(email)&password=\(password)"
        }else{
            newUrl = "\(RESET_PASSWORD)?phone=\(phone)&password=\(password)"
        }
        HTTPHelper().httpGetResponse(strURL: newUrl, params: nil, view: viewController,loader:loader) { (result, errors) in
            if result == nil{
                return
            }
            if (result as! NSDictionary).value(forKey: "status") as! String == "0"{
                viewController.showErrorGreen(msg: (result as! NSDictionary).value(forKey: "msg") as! String)
            }else{
                completion("","")
            }
        }
    }
    
    
    func GET_CHEF_LIST(params : [String:Any]?, viewController:UIViewController,loader:Bool, completion: @escaping (_ result: ModelChefList?, _ error: String)->()){

        HTTPHelper().httpGetResponse(strURL: CHEF_LIST_URL, params: params, view: viewController,loader:loader) { (result, errors) in
            if result == nil{
                completion(nil,"")
                return
            }
            let data = ModelChefList.init(fromDictionary: result as! [String : Any])
            if data.status == "1"{
               completion(data,"")
            }else{
                completion(nil,"")
                viewController.view.makeToast(data.msg)
            }
        }
    }
    func GET_SerachDish_LIST(params : [String:Any]?, viewController:UIViewController,loader:Bool, completion: @escaping (_ result: ModelSearchDishList?, _ error: String)->()){
        ////http://3.94.1.254/mobile/searchDishlist?name=test

        HTTPHelper().httpGetResponse(strURL: SEARCHDISH_URL, params: params, view: viewController,loader:loader) { (result, errors) in
            if result == nil{
                completion(nil,"")
                return
            }
            let data = ModelSearchDishList.init(fromDictionary: result as! [String : Any])
            if data.status == "1"{
               completion(data,"")
            }else{
                completion(nil,"")
            // viewController.showErrorGreen(msg: data.msg)
            }
        }
    }
    
    func GET_CUSINE_LIST(params : [String:Any]?, viewController:UIViewController,loader:Bool, completion: @escaping (_ result: ModelChefList?, _ error: String)->()){
           HTTPHelper().httpGetResponse(strURL: Cusine_LIST_URL, params: params, view: viewController,loader:loader) { (result, errors) in
               if result == nil{
                   completion(nil,"")
                   return
               }
               let data = ModelChefList.init(fromDictionary: result as! [String : Any])
               if data.status == "1"{
                  completion(data,"")
               }else{
                   completion(nil,"")
                   //viewController.showErrorGreen(msg: data.msg)
               }
           }
       }
    func GET_CART_LIST(params : [String:Any]?, viewController:UIViewController,loader:Bool, completion: @escaping (_ result: Model_CART?, _ error: String)->()){
        HTTPHelper().httpGetResponse(strURL: GET_CART_URL, params: params, view: viewController,loader:loader) { (result, errors) in
            if result == nil{
                return
            }
            let data = Model_CART.init(fromDictionary: result as! [String : Any])
            if data.status == "1"{
                completion(data,"")
            }else{
              completion(nil,"")
               // viewController.showErrorGreen(msg: data.msg)
            }
        }
    }
    func UPDATE_CART_LIST(params : [String:Any]?, viewController:UIViewController,loader:Bool, completion: @escaping (_ result: Model_CART?, _ error: String)->()){
        HTTPHelper().httpGetResponse(strURL: UPDATE_CART_URL, params: params, view: viewController,loader:loader) { (result, errors) in
            if result == nil{
                completion(nil,"")
                return
            }
            let data = Model_CART.init(fromDictionary: result as! [String : Any])
            if data.status == "1"{
                if data.cart_total == "0"{
                    if data.data.count > 0{
                        completion(data,"")

                    }else{
                        completion(nil,"")

                    }
                }else{
                     completion(data,"")
                }
            }else if data.status == "2"{
                viewController.view.makeToast(data.msg)
            }
            else{
                completion(nil,"")
                viewController.showErrorGreen(msg: data.msg)
            }
        }
    }
    
    func GET_FAV_CHEF_LIST(params : [String:Any]?, viewController:UIViewController,loader:Bool, completion: @escaping (_ result: ModelChefList?, _ error: String)->()){
        HTTPHelper().httpGetResponse(strURL: FavList, params: params, view: viewController,loader:loader) { (result, errors) in
            if result == nil{
                completion(nil,"")
                return
            }
            let data = ModelChefList.init(fromDictionary: result as! [String : Any])
            if data.status == "1"{
                completion(data,"")
            }else{
                 completion(data,"")
                viewController.showErrorGreen(msg: data.msg)
            }
        }
    }
    
    func Fav_API(params : [String:Any]?, viewController:UIViewController,loader:Bool, completion: @escaping (_ result: GernalModel?, _ error: String)->()){
        HTTPHelper().httpGetResponse(strURL: FavUnFAV_API, params: params, view: viewController,loader:loader) { (result, errors) in
            if result == nil{
                completion(nil,"")
                return
            }
            let data = GernalModel.init(fromDictionary: result as! [String : Any])
            if data.status == "1"{
                
                completion(data,"")
            }else{
                   viewController.navigationController?.view.makeToast(data.msg, duration: 3.0, position: .bottom)
            }
        }
    }
    
    func ChangePass_API(params : [String:Any]?, viewController:UIViewController,loader:Bool, completion: @escaping (_ result: GernalModel?, _ error: String)->()){
        HTTPHelper().httpGetResponse(strURL: CHANGEPASS_API, params: params, view: viewController,loader:loader) { (result, errors) in
            if result == nil{
                completion(nil,"")
                return
            }
            let data = GernalModel.init(fromDictionary: result as! [String : Any])
            if data.status == "1"{
                viewController.view.makeToast(data.msg)
                completion(data,"")
            }else{
                   viewController.navigationController?.view.makeToast(data.msg, duration: 3.0, position: .bottom)
            }
        }
    }
    func GetNotification(params : [String:Any]?, viewController:UIViewController,loader:Bool, completion: @escaping (_ result: MODEL_NOTIFICATION?, _ error: String)->()){
           HTTPHelper().httpGetResponse(strURL: notification_API, params: params, view: viewController,loader:loader) { (result, errors) in
               if result == nil{
                   completion(nil,"")
                   return
               }
               let data = MODEL_NOTIFICATION.init(fromDictionary: result as! [String : Any])
               if data.status == "1"{
                   
                   completion(data,"")
               }else{
                completion(nil,"")
                      viewController.navigationController?.view.makeToast(data.msg, duration: 3.0, position: .bottom)
               }
           }
       }
    func OfineMsgNotification(params : [String:Any]?, viewController:UIViewController,loader:Bool, completion: @escaping (_ result: GernalModel?, _ error: String)->()){
             HTTPHelper().httpGetResponse(strURL: SendNotifiationOfineUser, params: params, view: viewController,loader:loader) { (result, errors) in
                 if result == nil{
                     completion(nil,"")
                     return
                 }
                 let data = GernalModel.init(fromDictionary: result as! [String : Any])
                 if data.status == "1"{
                     
                     completion(data,"")
                 }else{
                  completion(nil,"")
                        viewController.navigationController?.view.makeToast(data.msg, duration: 3.0, position: .bottom)
                 }
             }
         }
    func DeleteNotification(params : [String:Any]?, viewController:UIViewController,loader:Bool, completion: @escaping (_ result: GernalModel?, _ error: String)->()){
              HTTPHelper().httpGetResponse(strURL: DeleteNotification_URL, params: params, view: viewController,loader:loader) { (result, errors) in
                  if result == nil{
                      completion(nil,"")
                      return
                  }
                  let data = GernalModel.init(fromDictionary: result as! [String : Any])
                  if data.status == "1"{
                      completion(data,"")
                  }else{
                         viewController.navigationController?.view.makeToast(data.msg, duration: 3.0, position: .bottom)
                  }
              }
          }
    func AddNotification(params : [String:Any]?, viewController:UIViewController,loader:Bool, completion: @escaping (_ result: GernalModel?, _ error: String)->()){
        HTTPHelper().httpGetResponse(strURL: AddNotification_API, params: params, view: viewController,loader:loader) { (result, errors) in
            if result == nil{
                completion(nil,"")
                return
            }
            let data = GernalModel.init(fromDictionary: result as! [String : Any])
            if data.status == "1"{
                
                completion(data,"")
            }else{
                   viewController.navigationController?.view.makeToast(data.msg, duration: 3.0, position: .bottom)
            }
        }
    }
    func Add_CART_API(params : [String:Any]?, viewController:UIViewController,loader:Bool, completion: @escaping (_ result: GernalModel?, _ error: String)->()){
        HTTPHelper().httpGetResponse(strURL: ADD_CART, params: params, view: viewController,loader:loader) { (result, errors) in
            if result == nil{
                completion(nil,"")
                return
            }
            let data = GernalModel.init(fromDictionary: result as! [String : Any])
            if data.status == "1"{
                completion(data,"")
            }else{
                completion(data,"error")
            }
            
        }
    }
    func DELETE_CART_API(params : [String:Any]?, viewController:UIViewController,loader:Bool, completion: @escaping (_ result: GernalModel?, _ error: String)->()){
        HTTPHelper().httpGetResponse(strURL: DELETE_CART_URL, params: params, view: viewController,loader:loader) { (result, errors) in
            if result == nil{
                completion(nil,"")
                return
            }
            let data = GernalModel.init(fromDictionary: result as! [String : Any])
            if data.status == "1"{
                completion(data,"")
            }else{
                completion(data,"error")
            }
        }
    }
    func GET_CHEF_LIST_Search(params : [String:Any]?, viewController:UIViewController,loader:Bool, completion: @escaping (_ result: ModelChefList?, _ error: String)->()){
        HTTPHelper().httpGetResponse(strURL: CHEF_LIST_URL, params: params, view: viewController,loader:loader) { (result, errors) in
            if result == nil{
                completion(nil,"")
                return
            }
            let data = ModelChefList.init(fromDictionary: result as! [String : Any])
            if data.status == "1"{
                completion(data,"")
            }else{
                viewController.showErrorGreen(msg: data.msg)
            }
        }
    }
    
    func AddAddress(params : [String:Any]?,isEdit:Bool, viewController:UIViewController,loader:Bool, completion: @escaping ()->()){
        HTTPHelper().httpGetResponse(strURL: isEdit ? EDIT_ADDRESS : ADD_ADDRESS, params: params, view: viewController,loader:loader) { (result, errors) in
            if result == nil{
                viewController.showErrorGreen(msg: "Server error")
                return
            }
            let data = result as! NSDictionary
            if data.value(forKey: "status") as! String == "1"{
                completion()
            }else{
                viewController.showErrorGreen(msg: data.value(forKey: "msg") as! String)
            }
        }
    }

    func supportAPI(params : [String:Any]?, viewController:UIViewController,loader:Bool, completion: @escaping ()->()){
        HTTPHelper().httpGetResponse(strURL: SUPPORT_URL, params: params, view: viewController,loader:loader) { (result, errors) in
            if result == nil{
                viewController.showErrorGreen(msg: "Server error")
                return
            }
            let data = result as! NSDictionary
            if data.value(forKey: "status") as! String == "1"{
                completion()
                viewController.showSuccess(msg: data.value(forKey: "msg") as! String)
            }else{
                viewController.showErrorGreen(msg: data.value(forKey: "msg") as! String)
            }
            
        }
    }

    
//    
    func CreateOrder(params : [String:String]?,loader:Bool, viewController:UIViewController, completion: @escaping (_ result: GernalModel?)->()){
        HTTPHelper().httpGetResponse(strURL: ORDER_URL, params: params, view: viewController,loader:loader) { (result, errors) in
            if result == nil{
                viewController.showErrorGreen(msg: "Server error")
                return
            }
            let data = GernalModel.init(fromDictionary: result as! [String : Any])
            if data.status == "1"{
                completion(data)
            }else{
                viewController.showErrorGreen(msg: data.msg)
            }
        }
    }
    func AddCard(params : [String:String]?,loader:Bool, viewController:UIViewController, completion: @escaping (_ result: GernalModel?)->()){
        HTTPHelper().httpGetResponse(strURL: saveCard_URL, params: params, view: viewController,loader:loader) { (result, errors) in
            if result == nil{
                viewController.showErrorGreen(msg: "Server error")
                return
            }
            let data = GernalModel.init(fromDictionary: result as! [String : Any])
            if data.status == "1"{
                completion(data)
            }else{
                viewController.showErrorGreen(msg: data.msg)
            }
        }
    }
    
    func MY_ORDER(params : [String:String]?,loader:Bool, viewController:UIViewController, completion: @escaping (_ result: Model_MyOrder?)->()){
        HTTPHelper().httpGetResponse(strURL: MY_ORDER_URL, params: params, view: viewController,loader:loader) { (result, errors) in
            if result == nil{
                viewController.showErrorGreen(msg: "Server error")
                return
            }
            let data = Model_MyOrder.init(fromDictionary: result as! [String : Any])
            if data.status == "1"{
                completion(data)
            }else{
                completion(nil)
                viewController.showErrorGreen(msg: data.msg)
            }
        }
    }
    func YearList(params : [String:String]?,loader:Bool, viewController:UIViewController, completion: @escaping (_ result: NSDictionary?)->()){
           HTTPHelper().httpGetResponse(strURL: YearList_URL, params: params, view: viewController,loader:loader) { (result, errors) in
               if result == nil{
                   viewController.showErrorGreen(msg: "Server error")
                   return
               }
              
            if (result as! NSDictionary).value(forKey: "status") as! String == "1"{
                completion((result as! NSDictionary))
               }else{
                   viewController.showErrorGreen(msg: "error")
               }
           }
       }
    func MY_CARD(params : [String:String]?,loader:Bool, viewController:UIViewController, completion: @escaping (_ result: ModelCARDLIST?)->()){
           HTTPHelper().httpGetResponse(strURL: MY_CARD_URL, params: params, view: viewController,loader:loader) { (result, errors) in
               if result == nil{
                   viewController.showErrorGreen(msg: "Server error")
                   return
               }
               let data = ModelCARDLIST.init(fromDictionary: result as! [String : Any])
               if data.status == "1"{
                   completion(data)
               }else{
                 completion(nil)
                viewController.showErrorGreen(msg: data.msg)
               }
           }
       }
    
    func RateChef(params : [String:String]?,loader:Bool, viewController:UIViewController, completion: @escaping (_ result: GernalModel?)->()){
        HTTPHelper().httpGetResponse(strURL: RATE_URL, params: params, view: viewController,loader:loader) { (result, errors) in
            if result == nil{
                viewController.showErrorGreen(msg: "Server error")
                return
            }
            let data = GernalModel.init(fromDictionary: result as! [String : Any])
            if data.status == "1"{
                completion(data)
            }else{
                viewController.showErrorGreen(msg: data.msg)
            }
        }
    }
    func RemoveCard(params : [String:String]?,loader:Bool, viewController:UIViewController, completion: @escaping (_ result: GernalModel?)->()){
        HTTPHelper().httpGetResponse(strURL: REMOVECARD_URL, params: params, view: viewController,loader:loader) { (result, errors) in
            if result == nil{
                viewController.showErrorGreen(msg: "Server error")
                return
            }
            let data = GernalModel.init(fromDictionary: result as! [String : Any])
            if data.status == "1"{
                completion(data)
            }else{
                viewController.showErrorGreen(msg: data.msg)
            }
        }
    }
    
    func supportAPI(params : [String:String]?,loader:Bool, viewController:UIViewController, completion: @escaping (_ result: GernalModel?)->()){
        HTTPHelper().httpGetResponse(strURL: SUPPORT_URL, params: params, view: viewController,loader:loader) { (result, errors) in
            if result == nil{
                viewController.showErrorGreen(msg: "Server error")
                return
            }
            let data = GernalModel.init(fromDictionary: result as! [String : Any])
            if data.status == "1"{
                completion(data)
            }else{
                viewController.showErrorGreen(msg: data.msg)
            }
        }
    }
    func MY_Reviews(params : [String:String]?,loader:Bool, viewController:UIViewController, completion: @escaping (_ result: MODELREVIEW?)->()){
        HTTPHelper().httpGetResponse(strURL: MY_REVIEW_URL, params: params, view: viewController,loader:loader) { (result, errors) in
            if result == nil{
                viewController.showErrorGreen(msg: "Server error")
                return
            }
            let data = MODELREVIEW.init(fromDictionary: result as! [String : Any])
            if data.status == "1"{
                completion(data)
            }else{
                viewController.showErrorGreen(msg: data.msg)
            }
        }
    }
    func GET_CHEF_DETAIL(params : [String:Any]?, viewController:UIViewController,loader:Bool, completion: @escaping (_ result: MODEL_CHEF_DETAIL?, _ error: String)->()){
        HTTPHelper().httpGetResponse(strURL: CHEF_DETAIL, params: params, view: viewController,loader:loader) { (result, errors) in
            if result == nil{
                completion(nil,"")
                return
            }
            let data = MODEL_CHEF_DETAIL.init(fromDictionary: result as! [String : Any])
            if data.status == "1"{
                completion(data,"")
            }else{
                viewController.showErrorGreen(msg: data.msg)
            }
            
        }
    }

    func UploadImage(params : [String:Any]?, viewController:UIViewController,loader:Bool,image:UIImage, completion: @escaping (_ result: NSDictionary?, _ error: String)->()){
        HTTPHelper().UploadDataWithImage(Url: UPLOAD_IMAGE_URL as NSString, dict: params! as NSDictionary, image: image, imageKey: "image_name", storyBoard: UIStoryboard(), navigation: viewController) { (result, error, code) in
             print(result)
            if result.value(forKey: "status") as! String == "1"{
            completion(result,"")
            }else{
                viewController.showErrorGreen(msg: result.value(forKey: "msg") as! String)
            }
        }
       
    }

}


