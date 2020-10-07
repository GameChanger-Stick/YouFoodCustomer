
//
//    RootClass.swift
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class MODELREVIEW{
    
    var info : [InfoReview]!
    var msg : String!
    var status : String!
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        info = [InfoReview]()
        if let infoArray = dictionary["info"] as? [[String:Any]]{
            for dic in infoArray{
                let value = InfoReview(fromDictionary: dic)
                info.append(value)
            }
        }
        msg = dictionary["msg"] as? String
        status = dictionary["status"] as? String
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
       
            if let infoArray = dictionary["info"] as? [[String:Any]]{
                for dic in infoArray{
                    let value = InfoReview(fromDictionary: dic)
                    info.append(value)
                }
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
//
//    Info.swift
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport




class InfoReview{
    
    var reviewdata : Reviewdata!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        if let reviewdataData = dictionary["reviewdata"] as? [String:Any]{
            reviewdata = Reviewdata(fromDictionary: reviewdataData)
        }
    }
    
 
}



class Reviewdata{
    
    var dtAddedDate : String!
    var dtModifiedDate : String!
    var flgAcStatus : AnyObject!
    var flgApproveStatus : String!
    var flgIsDelete : String!
    var flgReviewResponse : String!
    var inChefId : String!
    var inId : String!
    var inUserId : String!
    var rule : String!
    var stDescription : String!
    var stFirstName : String!
    var stFoodRating : Double!
    var stLastName : String!
    var stOrderNum : String!
    var stRestaurantName : String!
    var stReviewResponse : AnyObject!
    var profile_picture : String!
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        dtAddedDate = dictionary["dt_added_date"] as? String
        dtModifiedDate = dictionary["dt_modified_date"] as? String
        flgAcStatus = dictionary["flg_ac_status"] as? AnyObject
        flgApproveStatus = dictionary["flg_approve_status"] as? String
        flgIsDelete = dictionary["flg_is_delete"] as? String
        flgReviewResponse = dictionary["flg_review_response"] as? String
        inChefId = dictionary["in_chef_id"] as? String
        inId = dictionary["in_id"] as? String
        inUserId = dictionary["in_user_id"] as? String
        rule = dictionary["rule"] as? String
        stDescription = dictionary["st_description"] as? String
        stFirstName = dictionary["st_first_name"] as? String
        stLastName = dictionary["st_last_name"] as? String
        stOrderNum = dictionary["st_order_num"] as? String
        let ratee = dictionary["st_food_rating"] as? String ?? "0"
        let reatew = Double(ratee)
        stFoodRating = reatew
        stRestaurantName = dictionary["st_restaurant_name"] as? String
        stReviewResponse = dictionary["st_review_response"] as? AnyObject
        profile_picture = dictionary["profile_picture"] as? String

    }
    
    
}
