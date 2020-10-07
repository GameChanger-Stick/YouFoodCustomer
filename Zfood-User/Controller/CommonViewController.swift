//
//  CommonViewController.swift
//  Zfood-User
//
//  Created by bhavya on 8/26/19.
//  Copyright © 2019 WemakeAppz. All rights reserved.
//

import UIKit
import Stripe


class CommonViewController: UIViewController {
    var userDetail : Info?
    var chefDetail : MODEL_CHEF_DETAIL?

    var cartAvailable = Bool()
    override func viewDidLoad() {
        super.viewDidLoad()
       getdetailFromStore()
       
        
    }
    private func getdetailFromStore(){
        if let detail : [String:Any] = UserDefaults.standard.value(forKey: Constants.userDefaults.userDetail) as? [String : Any]{
            let userData = ModelUser.init(fromDictionary: detail)
            self.userDetail = userData.info
             getUser()
        }
       
    }
    func  getChefDetail(cehfID:String,loader:Bool,completion: @escaping (_ result: MODEL_CHEF_DETAIL?, _ error: Bool)->()){
           APIServices().GET_CHEF_DETAIL(params: ["in_chef_id":cehfID,"user_id":currentUser?.info.inUserId ?? "","lat":Double(userLAT),"lng":Double(userLNG)], viewController: self, loader: loader) { (result, error) in
            self.chefDetail = result
            completion(result, false)
            return
           }
        
       }
    func isCart(availble: @escaping (_ data: Model_CART?)->()){
        if !isguest{
        let param = ["user_id":currentUser?.info.inUserId ?? "","lat":GloLat,"lng":GloLng] as [String : Any]
        APIServices().GET_CART_LIST(params: param, viewController: self, loader: false) { (data, error) in
            if data?.status == "1"{
                availble(data!)
            }else{
                     availble(nil)
                
            }
        }
        }else{
            
        }
    }
    
    func getUser(){
        APIServices().GET_USER(params: ["user_id":userDetail?.inUserId ?? ""], viewController: self, loader: true) { (details, error) in
            if details != nil{
                if details?.status == "1"{
                    self.userDetail = details?.info
                    if tokenStrip != ""{
                                Stripe.setDefaultPublishableKey(tokenStrip)
                           }
                }
            }else{
            }
        }
    }
    func LogoutUser(completion: @escaping(()->Void)){
           APIServices().Logout(params: ["user_id":userDetail?.inUserId ?? ""], viewController: self, loader: true) { (details, error) in
               if details != nil{
                   if details?.status == "1"{
                    completion()
                   }
               }else{
               }
           }
       }
}
