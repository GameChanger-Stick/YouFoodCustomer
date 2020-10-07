
//
//    RootClass.swift
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class ModelUser{
    
    var info : Info!
    var msg : String!
    var token = ""
    var status : String!
    init(fromDictionary dictionary: [String:Any]){
        if let infoData = dictionary["info"] as? [String:Any]{
            info = Info(fromDictionary: infoData)
        }
        if let seting = dictionary["setting_data"] as? [String:Any]{
            if let tokenS = seting["stripe_key"] as? String{
               tokenStrip = tokenS
            }
        }
        msg = dictionary["msg"] as? String
        token = dictionary["token"] as? String ?? ""
       // loginToken = token
        status = dictionary["status"] as? String
    }
  
    func toDictionary() -> [String:Any]{
        var dictionary = [String:Any]()
        if info != nil{
            dictionary["info"] = info.toDictionary()
        }
        if msg != nil{
            dictionary["msg"] = msg
        }
        if status != nil{
            dictionary["status"] = status
        }
        return dictionary
    }
}

class Info{
    var firstName : String!
    var inUserId : String!
    var lastName : String!
    var mobile : String!
    var referal : String!
    var userEmail : String!
    var imgProfile  :String!
    var type = "1"
    var stripKey : String!
    var profileAddress : String!
    var lat : String!
    var lng : String!
  
    init(fromDictionary dictionary: [String:Any]){
        //profile_picture
     if let stripe_key3 = dictionary["stripe_key"] as? String {
            self.stripKey = stripe_key3
            tokenStrip = self.stripKey
        }
        firstName = dictionary["first_name"] as? String
        if let address =  dictionary["profile_address"] as? String{
            self.profileAddress = address
        }else{
            self.profileAddress = ""
        }
        if let latA = dictionary["lat"] as? String{
            lat = latA
        }else{
            lat = ""
        }
        if let lngQ = dictionary["lng"] as? String{
            self.lng = lngQ
        }else{
            self.lng = ""
        }
        imgProfile = dictionary["profile_picture"] as? String
        inUserId = dictionary["in_user_id"] as? String
        userIDHeadder = inUserId
        lastName = dictionary["last_name"] as? String
        mobile = dictionary["mobile"] as? String
        referal = dictionary["referal"] as? String
        userEmail = dictionary["user_email"] as? String
    }
  
    func toDictionary() -> [String:Any]{
        var dictionary = [String:Any]()
        if firstName != nil{
            dictionary["first_name"] = firstName
        }
        if inUserId != nil{
            dictionary["in_user_id"] = inUserId
        }
        if lastName != nil{
            dictionary["last_name"] = lastName
        }
        if mobile != nil{
            dictionary["mobile"] = mobile
        }
        if referal != nil{
            dictionary["referal"] = referal
        }
        if userEmail != nil{
            dictionary["user_email"] = userEmail
        }
        return dictionary
    }
    
    
}
