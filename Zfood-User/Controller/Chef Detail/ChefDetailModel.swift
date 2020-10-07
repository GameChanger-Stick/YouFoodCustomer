//
//    RootClass.swift
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class MODEL_CHEF_DETAIL{
    
    var accountDetail : AccountDetail!
    var cuisines : [DishTypes]!
    var info : ChefInfoModel!
    var msg : String!
    var reviews : [Review]!
    var status : String!
  
    init(fromDictionary dictionary: [String:Any]){
        if let accountDetailData = dictionary["account_detail"] as? [String:Any]{
            accountDetail = AccountDetail(fromDictionary: accountDetailData)
        }
        cuisines = [DishTypes]()
        if let cuisinesArray = dictionary["dishtypes"] as? [[String:Any]]{
            for dic in cuisinesArray{
                let value = DishTypes(fromDictionary: dic)
                cuisines.append(value)
            }
        }
        if let infoData = dictionary["info"] as? [String:Any]{
            info = ChefInfoModel(fromDictionary: infoData)
        }
        msg = dictionary["msg"] as? String
      
        reviews = [Review]()
        if let reviewsArray = dictionary["reviews"] as? [[String:Any]]{
            for dic in reviewsArray{
                let value = Review(fromDictionary: dic)
                reviews.append(value)
            }
        }
        status = dictionary["status"] as? String
    }
}

class Review{
    
    var dtAddedDate : String!
    var dtModifiedDate : String!
    var flgAcStatus : String!
    var flgApproveStatus : String!
    var flgIsDelete : String!
    var flgReviewResponse : String!
    var inChefId : String!
    var inId : String!
    var inUserId : String!
    var rule : String!
    var stDescription : String!
    var stFoodRating : Double!
    var stReviewResponse : String!
    var name : String!
    var profile_picture : String!
    //var firstname : String!
  
    init(fromDictionary dictionary: [String:Any]){
        name = dictionary["firstname"] as? String
        dtAddedDate = dictionary["dt_added_date"] as? String
        dtModifiedDate = dictionary["dt_modified_date"] as? String ?? ""
        flgAcStatus = dictionary["flg_ac_status"] as? String ?? ""
        flgApproveStatus = dictionary["flg_approve_status"] as? String
        flgIsDelete = dictionary["flg_is_delete"] as? String
        flgReviewResponse = dictionary["flg_review_response"] as? String
        inChefId = dictionary["in_chef_id"] as? String
        inId = dictionary["in_id"] as? String
        inUserId = dictionary["in_user_id"] as? String
        rule = dictionary["rule"] as? String
        stDescription = dictionary["st_description"] as? String
        let ratee = dictionary["st_food_rating"] as? String ?? "0"
        let reatew = Double(ratee)
        stFoodRating = reatew
        stReviewResponse = dictionary["st_review_response"] as? String ?? ""
        profile_picture = dictionary["profile_picture"] as? String ?? ""

    }
    
    func toDictionary() -> [String:Any]{
        var dictionary = [String:Any]()
        if dtAddedDate != nil{
            dictionary["dt_added_date"] = dtAddedDate
        }
        if dtModifiedDate != nil{
            dictionary["dt_modified_date"] = dtModifiedDate
        }
        if flgAcStatus != nil{
            dictionary["flg_ac_status"] = flgAcStatus
        }
        if flgApproveStatus != nil{
            dictionary["flg_approve_status"] = flgApproveStatus
        }
        if flgIsDelete != nil{
            dictionary["flg_is_delete"] = flgIsDelete
        }
        if flgReviewResponse != nil{
            dictionary["flg_review_response"] = flgReviewResponse
        }
        if inChefId != nil{
            dictionary["in_chef_id"] = inChefId
        }
        if inId != nil{
            dictionary["in_id"] = inId
        }
        if inUserId != nil{
            dictionary["in_user_id"] = inUserId
        }
        if rule != nil{
            dictionary["rule"] = rule
        }
        if stDescription != nil{
            dictionary["st_description"] = stDescription
        }
        if stFoodRating != nil{
            dictionary["st_food_rating"] = stFoodRating
        }
        if stReviewResponse != nil{
            dictionary["st_review_response"] = stReviewResponse
        }
        return dictionary
    }
}



class ChefInfoModel{
    
    var isBlocked : String!
    var acStatus : String!
    var address1 : String!
    var address2 : String!
    var addressId : String!
    var chefBio : String!
    var chefDesc : String!
    var chefId : String!
    var chefName : String!
    var chefState : String!
    var chefSuburb : String!
    var chefZip : String!
    var coverImg : String!
    var displayImg : String!
    var dob : String!
    var email : String!
    var gender : String!
    var inChefId : String!
    var lat : String!
    var lng : String!
    var minOrder : String!
    var mobile : String!
    var noOrder : String!
    var profileImg : String!
    var rating : String!
    var secEmail : String!
    var secMobile : String!
    var stMobile : String!
    var website : String!
    var status : NSAttributedString!
    var time : String!
    var maxOrder : String!
    var cuisinesNAme : String!
    var fav : String!
    var facebook_url : String!
    var website_url : String!
    var availablity : String!
    var instaLink : String!
    var order_type : String!
    var smallAddress : String!
    var handler : String!
    var freeDish : String!
 var todayAvailable = false
    init(fromDictionary dictionary: [String:Any]){
        // What ever range you want to give
      freeDish = dictionary["donor"] as? String
        self.handler = dictionary["foodHandler"] as? String
        order_type = dictionary["order_type"] as? String
availablity = dictionary["availablity"] as? String
        if let sta = dictionary["status"] as? String{
            if sta == "1"{
                status = "OPEN".attributedStringWithColor("OPEN", color: UIColor.green)
            }else{
                 status = "CLOSE".attributedStringWithColor("CLOSE", color: UIColor.red)
            }
        }
        instaLink = dictionary["instagram_url"] as? String
        smallAddress = dictionary["small_address"] as? String
        facebook_url = dictionary["facebook_url"] as? String
        website_url = dictionary["website_url"] as? String
        maxOrder = dictionary["max_order"] as? String

        
        cuisinesNAme = dictionary["cuisine_names"] as? String
        time = "\(dictionary["cooking_time"] as? String ?? "0") min"
        isBlocked = dictionary["IsBlocked"] as? String
         fav = dictionary["fav"] as? String
        acStatus = dictionary["ac_status"] as? String
        address1 = dictionary["address1"] as? String
        address2 = dictionary["address2"] as? String
        addressId = dictionary["address_id"] as? String ?? ""
        chefBio = dictionary["chef_bio"] as? String
        chefDesc = dictionary["chef_desc"] as? String
        chefId = dictionary["chef_id"] as? String
        chefName = dictionary["chef_name"] as? String
        chefState = dictionary["chef_state"] as? String
        chefSuburb = dictionary["chef_suburb"] as? String
        chefZip = dictionary["chef_zip"] as? String
        coverImg = dictionary["coverImg"] as? String
        displayImg = dictionary["displayImg"] as? String
        dob = dictionary["dob"] as? String
        email = dictionary["email"] as? String
        gender = dictionary["gender"] as? String
        inChefId = dictionary["in_chef_id"] as? String
        lat = dictionary["lat"] as? String
        lng = dictionary["lng"] as? String
        minOrder = dictionary["min_order"] as? String ?? ""
        mobile = dictionary["mobile"] as? String
        noOrder = dictionary["no_order"] as? String
        profileImg = dictionary["profileImg"] as? String
        if let rating3 = dictionary["rating"] as? String{
             self.rating = rating3
        }else{
             self.rating = "0.0"
        }
        if rating == ""{
           
        }
        secEmail = dictionary["sec_email"] as? String ?? ""
        secMobile = dictionary["sec_mobile"] as? String ?? ""
        stMobile = dictionary["st_mobile"] as? String
        website = dictionary["website"] as? String ?? ""
        todayAvailable = self.DateAvailable(openDays: availablity)

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


class DishTypes{
    
    var cuisineId : String!
    var cuisineImageName : String!
    var cuisineName : String!
    var dishdetails : [Dishdetail]!
 
    init(fromDictionary dictionary: [String:Any]){
        cuisineId = dictionary["cuisine_id"] as? String
        cuisineImageName = dictionary["cuisine_image_name"] as? String
        cuisineName = dictionary["dishtype_name"] as? String
        dishdetails = [Dishdetail]()
        if let dishdetailsArray = dictionary["dishdetails"] as? [[String:Any]]{
            for dic in dishdetailsArray{
                let value = Dishdetail(fromDictionary: dic)
                dishdetails.append(value)
            }
        }
    }
}

class Dishdetail{
    
    var dishCuisineId : String!
    var dishDesription : String!
    var image : String!
    var inDishId : String!
    var stDishName : String!
    var stPrice : String!
    var dishImage : [DishImage]!
    var cooking_time : String!
    var min_order : String!
    var maxOrder : String!
    var servingSize : String!
    init(fromDictionary dictionary: [String:Any]){
        dishCuisineId = dictionary["dish_cuisine_id"] as? String
        servingSize = dictionary["st_serving_size"] as? String

        maxOrder = dictionary["max_order"] as? String
        let timeC = dictionary["cooking_time"] as? String
        let timeA = Int(timeC ?? "0")
        let touble = minutesToHoursMinutes(minutes: timeA ?? 0)
        self.cooking_time =  "\(touble.hours)hours \(touble.leftMinutes)min"
        
        min_order = dictionary["min_order"] as? String
        dishDesription = dictionary["dish_desription"] as? String
        image = dictionary["image"] as? String
        inDishId = dictionary["in_dish_id"] as? String
        stDishName = dictionary["st_dish_name"] as? String
        stPrice = dictionary["st_price"] as? String
        dishImage = [DishImage]()
        if let dishImageArray = dictionary["dish_image"] as? [[String:Any]]{
            for dic in dishImageArray{
                let value = DishImage(fromDictionary: dic)
                dishImage.append(value)
            }
        }
        if dishImage.count != 0{
        image = dishImage[0].imageURL
        }
    }
    func minutesToHoursMinutes (minutes : Int) -> (hours : Int , leftMinutes : Int) {
        return (minutes / 60, (minutes % 60))
    }
}




class DishImage{

    var id : String!
    var imageURL : String!
    var inDishId : String!
    var isMainImage : String!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        id = dictionary["id"] as? String
        imageURL = dictionary["image_URL"] as? String
        inDishId = dictionary["in_dish_id"] as? String
        isMainImage = dictionary["is_main_image"] as? String
    }
}

class AccountDetail{
    
    var accountNumber : String!
    var accountType : String!
    var bankName : String!
    var flgAcStatus : String!
    var flgDelStatus : String!
    var id : String!
    var inChefId : String!
    var payeeName : String!
    var routingNumber : String!
    var rule : String!
    var shortCode : String!
    
    init(fromDictionary dictionary: [String:Any]){
        accountNumber = dictionary["account_number"] as? String
        accountType = dictionary["account_type"] as? String
        bankName = dictionary["bank_name"] as? String
        flgAcStatus = dictionary["flg_ac_status"] as? String
        flgDelStatus = dictionary["flg_del_status"] as? String
        id = dictionary["id"] as? String
        inChefId = dictionary["in_chef_id"] as? String
        payeeName = dictionary["payee_name"] as? String
        routingNumber = dictionary["routing_number"] as? String
        rule = dictionary["rule"] as? String
        shortCode = dictionary["short_code"] as? String
    }
}
