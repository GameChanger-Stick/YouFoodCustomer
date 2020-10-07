//
//    RootClass.swift
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class ModelChefList{
    
    var chefInfo : [ChefInfo]!
    var cuisinedata : [Cuisinedata]!

    var msg : String!
    var status : String!
    
    init(fromDictionary dictionary: [String:Any]){
        chefInfo = [ChefInfo]()
        if let chefInfoArray = dictionary["ChefInfo"] as? [[String:Any]]{
            for dic in chefInfoArray{
                let value = ChefInfo(fromDictionary: dic)
                chefInfo.append(value)
            }
        }
        cuisinedata = [Cuisinedata]()
        if let cuisinedataArray = dictionary["cuisinedata"] as? [[String:Any]]{
            let dicAll = ["id":"","image":"","name":"All"]
            cuisinedata.append(Cuisinedata(fromDictionary: dicAll))
            for dic in cuisinedataArray{
                let value = Cuisinedata(fromDictionary: dic)
                cuisinedata.append(value)
            }
        }
        msg = dictionary["msg"] as? String
        status = dictionary["status"] as? String
    }
    
    func toDictionary() -> [String:Any]{
        var dictionary = [String:Any]()
        if chefInfo != nil{
            var dictionaryElements = [[String:Any]]()
            for chefInfoElement in chefInfo {
                dictionaryElements.append(chefInfoElement.toDictionary())
            }
            dictionary["ChefInfo"] = dictionaryElements
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


class ChefInfo{
    
    var addressId : String?
    var chefCoverImage : String!
    var chefDisplayImage : String!
    var chefDob : String!
    var chefGender : String!
    var chefProfileImage : String!
    var flgAcStatus : String!
    var flgIsDelete : String!
    var flgRestaurantApprove : String!
    var inAdminId : String!
    var inChefId : String!
    var stBio : String!
    var stContactNo : String!
    var stDescription : String!
    var stEmail : String!
    var stMinOrder : String?
    var stPostCode : String!
    var chefName = ""
    var handler :String?
    var dishlist : [Dishlist1]!

    var stSecondaryEmail : String?
    var stSecondaryMobile : String?
    var stState : String?
    var stSuburb : String?
    var stWebsite : String?
    var cookingTime : String!
    var rating : String!
    var fav : String!
    var address1 : String!
    var isexpand = false
    var order_type : String!
    var availablity : String!
    var distance : String!
    var todayAvailable = false
    var no_order : String!
    var smallAddress : String!
    var freeDish : String!
    init(fromDictionary dictionary: [String:Any]){
        if let dic = dictionary["distance"] as? String{
            let dis = dic.FloatValue()
            self.distance = String(format:"%.2f Miles", dis)
        }
        self.handler = dictionary["foodHandler"] as? String
    no_order = dictionary["totalreviews"] as? String
        freeDish = dictionary["donor"] as? String

        addressId = dictionary["address_id"] as? String
        order_type = dictionary["order_type"] as? String
        availablity = dictionary["availablity"] as? String
        fav = dictionary["fav"] as? String
        address1 = dictionary["address1"] as? String
        chefCoverImage = dictionary["chef_cover_image"] as? String
         cookingTime = dictionary["cooking_time"] as? String
        chefDisplayImage = dictionary["chef_display_image"] as? String
        chefDob = dictionary["chef_dob"] as? String
        rating = dictionary["rating"] as? String
        if rating == ""{
            self.rating = "0"
        }
        dishlist = [Dishlist1]()
        if let dishlistArray = dictionary["dishlist"] as? [[String:Any]]{
            for dic in dishlistArray{
                let value = Dishlist1(fromDictionary: dic)
                dishlist.append(value)
            }
        }
        smallAddress = dictionary["small_address"] as? String
        chefGender = dictionary["chef_gender"] as? String
        chefProfileImage = dictionary["chef_profile_image"] as? String
        flgAcStatus = dictionary["flg_ac_status"] as? String
        flgIsDelete = dictionary["flg_is_delete"] as? String
        flgRestaurantApprove = dictionary["flg_restaurant_approve"] as? String
        inAdminId = dictionary["in_admin_id"] as? String
        inChefId = dictionary["in_chef_id"] as? String
        stBio = dictionary["st_bio"] as? String
        stContactNo = dictionary["st_contact_no"] as? String
        stDescription = dictionary["st_description"] as? String
        stEmail = dictionary["st_email"] as? String
        stMinOrder = dictionary["st_min_order"] as? String
        stPostCode = dictionary["st_post_code"] as? String
        chefName = dictionary["chef_name"] as? String ?? ""
        stSecondaryEmail = dictionary["st_secondary_email"] as? String
        stSecondaryMobile = dictionary["st_secondary_mobile"] as? String
        stState = dictionary["st_state"] as? String
        stSuburb = dictionary["st_suburb"] as? String
        stWebsite = dictionary["st_website"] as? String
        todayAvailable = self.DateAvailable(openDays: availablity)
    }
    

    func toDictionary() -> [String:Any]{
        var dictionary = [String:Any]()
        if addressId != nil{
            dictionary["address_id"] = addressId
        }
        if chefCoverImage != nil{
            dictionary["chef_cover_image"] = chefCoverImage
        }
        if chefDisplayImage != nil{
            dictionary["chef_display_image"] = chefDisplayImage
        }
        if chefDob != nil{
            dictionary["chef_dob"] = chefDob
        }
        if chefGender != nil{
            dictionary["chef_gender"] = chefGender
        }
        if chefProfileImage != nil{
            dictionary["chef_profile_image"] = chefProfileImage
        }
        if flgAcStatus != nil{
            dictionary["flg_ac_status"] = flgAcStatus
        }
        if flgIsDelete != nil{
            dictionary["flg_is_delete"] = flgIsDelete
        }
        if flgRestaurantApprove != nil{
            dictionary["flg_restaurant_approve"] = flgRestaurantApprove
        }
        if inAdminId != nil{
            dictionary["in_admin_id"] = inAdminId
        }
        if inChefId != nil{
            dictionary["in_chef_id"] = inChefId
        }
        if stBio != nil{
            dictionary["st_bio"] = stBio
        }
        if stContactNo != nil{
            dictionary["st_contact_no"] = stContactNo
        }
        if stDescription != nil{
            dictionary["st_description"] = stDescription
        }
        if stEmail != nil{
            dictionary["st_email"] = stEmail
        }
        if stMinOrder != nil{
            dictionary["st_min_order"] = stMinOrder
        }
        if stPostCode != nil{
            dictionary["st_post_code"] = stPostCode
        }
        if chefName != nil{
            dictionary["chef_name"] = chefName
        }
        if dishlist != nil{
            var dictionaryElements = [[String:Any]]()
            for dishlistElement in dishlist {
                dictionaryElements.append(dishlistElement.toDictionary())
            }
            dictionary["dishlist"] = dictionaryElements
        }
        if stSecondaryEmail != nil{
            dictionary["st_secondary_email"] = stSecondaryEmail
        }
        if stSecondaryMobile != nil{
            dictionary["st_secondary_mobile"] = stSecondaryMobile
        }
        if stState != nil{
            dictionary["st_state"] = stState
        }
        if stSuburb != nil{
            dictionary["st_suburb"] = stSuburb
        }
        if stWebsite != nil{
            dictionary["st_website"] = stWebsite
        }
        return dictionary
    }
    func DateAvailable(openDays:String?) -> Bool{
        if openDays == ""{
            return false
        }
           if let arr = openDays?.components(separatedBy: ",") {
               if arr.contains(Date().getNumberToCompareDate()){
                   return true
               }
           }
           return false
       }
}

class Cuisinedata{
    
    var id : String!
    var image : String!
    var name : String!
    var totalChef : String!
    var state :  String!
    
    init(fromDictionary dictionary: [String:Any]){
        id = dictionary["id"] as? String
        image = dictionary["image"] as? String
        name = dictionary["name"] as? String
        totalChef = dictionary["total_chef"] as? String
        state = dictionary["state"] as? String
    }
   
}

class GernalModel{
    var msg : String!
    var status : String!
     init(fromDictionary dictionary: [String:Any]){
        msg = dictionary["msg"] as? String
        status = dictionary["status"] as? String
    }
}





//
//    Dishlist.swift
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



class Dishlist1{

    var cookingTime : String!
    var dishdiet : String!
    var flgDishType : String!
    var imageURL : String!
    var inChefId : String!
    var inCuisineId : String!
    var stDishName : String!
    var stPrice : String!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        cookingTime = dictionary["cooking_time"] as? String
        dishdiet = dictionary["dishdiet"] as? String
        flgDishType = dictionary["flg_dish_type"] as? String
        imageURL = dictionary["imageURL"] as? String
        inChefId = dictionary["in_chef_id"] as? String
        inCuisineId = dictionary["in_cuisine_id"] as? String
        stDishName = dictionary["st_dish_name"] as? String
        stPrice = dictionary["st_price"] as? String
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if cookingTime != nil{
            dictionary["cooking_time"] = cookingTime
        }
        if dishdiet != nil{
            dictionary["dishdiet"] = dishdiet
        }
        if flgDishType != nil{
            dictionary["flg_dish_type"] = flgDishType
        }
        if imageURL != nil{
            dictionary["imageURL"] = imageURL
        }
        if inChefId != nil{
            dictionary["in_chef_id"] = inChefId
        }
        if inCuisineId != nil{
            dictionary["in_cuisine_id"] = inCuisineId
        }
        if stDishName != nil{
            dictionary["st_dish_name"] = stDishName
        }
        if stPrice != nil{
            dictionary["st_price"] = stPrice
        }
        return dictionary
    }
}
 
