
//
//    RootClass.swift
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class Model_CART{
    
    var data : [CartData]!
    var msg : String!
    var status : String!
    var cart_total : String!
    var ChefData : ChefInfoModel!
    var settingData : SettingData!

    
    init(fromDictionary dictionary: [String:Any]){
        data = [CartData]()
        if let dataArray = dictionary["data"] as? [[String:Any]]{
            for dic in dataArray{
                let value = CartData(fromDictionary: dic)
                data.append(value)
            }
        }
        if let settingDataData = dictionary["setting_data"] as? [String:Any]{
            settingData = SettingData(fromDictionary: settingDataData)
        }
        if let infoData = dictionary["chefdata"] as? [String:Any]{
                   ChefData = ChefInfoModel(fromDictionary: infoData)
               }
        msg = dictionary["msg"] as? String
        cart_total = dictionary["cart_total"] as? String
        status = dictionary["status"] as? String
    }
   
    
    func toDictionary() -> [String:Any]{
        var dictionary = [String:Any]()
        if data != nil{
            var dictionaryElements = [[String:Any]]()
            for dataElement in data {
                dictionaryElements.append(dataElement.toDictionary())
            }
            dictionary["data"] = dictionaryElements
        }
        if msg != nil{
            dictionary["msg"] = msg
        }
        if status != nil{
            dictionary["status"] = status
        }
        return dictionary
    }
    
   
    @objc required init(coder aDecoder: NSCoder)
    {
        data = aDecoder.decodeObject(forKey :"data") as? [CartData]
        msg = aDecoder.decodeObject(forKey: "msg") as? String
        status = aDecoder.decodeObject(forKey: "status") as? String
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if data != nil{
            aCoder.encode(data, forKey: "data")
        }
        if msg != nil{
            aCoder.encode(msg, forKey: "msg")
        }
        if status != nil{
            aCoder.encode(status, forKey: "status")
        }
    }
}

class CartData : NSObject, NSCoding{
    var chefInfo : ChefInfo!
    var chefId : String!
    var dishId : String!
    var dishInfo : DishInfo!
    var qty : String!
    var id : String!
    var userId : String!
    var in_chef_Id : String!
    var imgDish = ""
   
    init(fromDictionary dictionary: [String:Any]){
        chefId = dictionary["chef_id"] as? String
        if let chefInfoData = dictionary["chef_info"] as? [String:Any]{
            chefInfo = ChefInfo(fromDictionary: chefInfoData)
        }
        if let dishImagesData = dictionary["dish_images"] as? [[String:Any]?]{
            if dishImagesData.count != 0{
            if let sing = dishImagesData[0]{
                if let url = sing["image_URL"] as? String{
                    self.imgDish = url
                }
                }}
               }
        
        id = dictionary["id"] as? String ?? ""
          in_chef_Id = dictionary["in_chef_id"] as? String ?? ""
        dishId = dictionary["dish_id"] as? String ?? ""
        if var dishInfoData = dictionary["dish_info"] as? [String:Any]{
            dishInfoData["qty"] = dictionary["qty"] as? String
            dishInfo = DishInfo(fromDictionary: dishInfoData)
        }
        qty = dictionary["qty"] as? String
        userId = dictionary["user_id"] as? String
    }
  
    func toDictionary() -> [String:Any]{
        var dictionary = [String:Any]()
        if chefId != nil{
            dictionary["chef_id"] = chefId
        }
        if dishId != nil{
            dictionary["dish_id"] = dishId
        }
        if dishInfo != nil{
            dictionary["dish_info"] = dishInfo.toDictionary()
        }
        if qty != nil{
            dictionary["qty"] = qty
        }
        if userId != nil{
            dictionary["user_id"] = userId
        }
        return dictionary
    }
   
    @objc required init(coder aDecoder: NSCoder)
    {
        chefId = aDecoder.decodeObject(forKey: "chef_id") as? String
        dishId = aDecoder.decodeObject(forKey: "dish_id") as? String
        dishInfo = aDecoder.decodeObject(forKey: "dish_info") as? DishInfo
        qty = aDecoder.decodeObject(forKey: "qty") as? String
        userId = aDecoder.decodeObject(forKey: "user_id") as? String
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if chefId != nil{
            aCoder.encode(chefId, forKey: "chef_id")
        }
        if dishId != nil{
            aCoder.encode(dishId, forKey: "dish_id")
        }
        if dishInfo != nil{
            aCoder.encode(dishInfo, forKey: "dish_info")
        }
        if qty != nil{
            aCoder.encode(qty, forKey: "qty")
        }
        if userId != nil{
            aCoder.encode(userId, forKey: "user_id")
        }
        
    }
    
}


class DishInfo{
    
    var availablity : String!
    var cookingTime : String!
    var diettypeName : String!
    var dishdiet : String!
    var dishtypeName : String!
    var dtAddedDate : String!
    var dtModifiedDate : AnyObject!
    var flgAcStatus : String!
    var flgAddChoices : String!
    var flgApprovalStatus : String!
    var flgDishType : String!
    var flgIsDelete : String!
    var flgPopularDish : String!
    var imageURL : String!
    var imagename : String!
    var inChefId : String!
    var inCuisineId : String!
    var inDishId : String!
    var maxQtyPeruser : String!
    var outOfStock : String!
    var rejectReason : String!
    var stAttributeName : AnyObject!
    var stDishDesription : String!
    var stDishName : String!
    var stPrice : String!
    var stServingSize : String!
    var subCuisineId : String!
    var totalPrice : String!
    var qty : String!
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        availablity = dictionary["availablity"] as? String
        cookingTime = dictionary["cooking_time"] as? String
        diettypeName = dictionary["diettype_name"] as? String
        dishdiet = dictionary["dishdiet"] as? String
        dishtypeName = dictionary["dishtype_name"] as? String
        dtAddedDate = dictionary["dt_added_date"] as? String
        dtModifiedDate = dictionary["dt_modified_date"] as? AnyObject
        flgAcStatus = dictionary["flg_ac_status"] as? String
        flgAddChoices = dictionary["flg_add_choices"] as? String
        flgApprovalStatus = dictionary["flg_approval_status"] as? String
        flgDishType = dictionary["flg_dish_type"] as? String
        flgIsDelete = dictionary["flg_is_delete"] as? String
        flgPopularDish = dictionary["flg_popular_dish"] as? String
        imageURL = dictionary["imageURL"] as? String
        imagename = dictionary["imagename"] as? String
        inChefId = dictionary["in_chef_id"] as? String
        inCuisineId = dictionary["in_cuisine_id"] as? String
        inDishId = dictionary["in_dish_id"] as? String
        maxQtyPeruser = dictionary["max_qty_peruser"] as? String
        outOfStock = dictionary["out_of_stock"] as? String
        rejectReason = dictionary["reject_reason"] as? String
        stAttributeName = dictionary["st_attribute_name"] as? AnyObject
        stDishDesription = dictionary["st_dish_desription"] as? String
        stDishName = dictionary["st_dish_name"] as? String
        stPrice = dictionary["st_price"] as? String
        let disPrice = stPrice.FloatValue()
        let qty = (dictionary["qty"] as? String)?.FloatValue()
        stServingSize = dictionary["st_serving_size"] as? String
        subCuisineId = dictionary["sub_cuisine_id"] as? String
        totalPrice = String(disPrice * (qty ?? 0.0))
    }
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if availablity != nil{
            dictionary["availablity"] = availablity
        }
        if cookingTime != nil{
            dictionary["cooking_time"] = cookingTime
        }
        if diettypeName != nil{
            dictionary["diettype_name"] = diettypeName
        }
        if dishdiet != nil{
            dictionary["dishdiet"] = dishdiet
        }
        if dishtypeName != nil{
            dictionary["dishtype_name"] = dishtypeName
        }
        if dtAddedDate != nil{
            dictionary["dt_added_date"] = dtAddedDate
        }
        if dtModifiedDate != nil{
            dictionary["dt_modified_date"] = dtModifiedDate
        }
        if flgAcStatus != nil{
            dictionary["flg_ac_status"] = flgAcStatus
        }
        if flgAddChoices != nil{
            dictionary["flg_add_choices"] = flgAddChoices
        }
        if flgApprovalStatus != nil{
            dictionary["flg_approval_status"] = flgApprovalStatus
        }
        if flgDishType != nil{
            dictionary["flg_dish_type"] = flgDishType
        }
        if flgIsDelete != nil{
            dictionary["flg_is_delete"] = flgIsDelete
        }
        if flgPopularDish != nil{
            dictionary["flg_popular_dish"] = flgPopularDish
        }
        if imageURL != nil{
            dictionary["imageURL"] = imageURL
        }
        if imagename != nil{
            dictionary["imagename"] = imagename
        }
        if inChefId != nil{
            dictionary["in_chef_id"] = inChefId
        }
        if inCuisineId != nil{
            dictionary["in_cuisine_id"] = inCuisineId
        }
        if inDishId != nil{
            dictionary["in_dish_id"] = inDishId
        }
        if maxQtyPeruser != nil{
            dictionary["max_qty_peruser"] = maxQtyPeruser
        }
        if outOfStock != nil{
            dictionary["out_of_stock"] = outOfStock
        }
        if rejectReason != nil{
            dictionary["reject_reason"] = rejectReason
        }
        if stAttributeName != nil{
            dictionary["st_attribute_name"] = stAttributeName
        }
        if stDishDesription != nil{
            dictionary["st_dish_desription"] = stDishDesription
        }
        if stDishName != nil{
            dictionary["st_dish_name"] = stDishName
        }
        if stPrice != nil{
            dictionary["st_price"] = stPrice
        }
        if stServingSize != nil{
            dictionary["st_serving_size"] = stServingSize
        }
        if subCuisineId != nil{
            dictionary["sub_cuisine_id"] = subCuisineId
        }
        return dictionary
    }
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder){
        availablity = aDecoder.decodeObject(forKey: "availablity") as? String
        cookingTime = aDecoder.decodeObject(forKey: "cooking_time") as? String
        diettypeName = aDecoder.decodeObject(forKey: "diettype_name") as? String
        dishdiet = aDecoder.decodeObject(forKey: "dishdiet") as? String
        dishtypeName = aDecoder.decodeObject(forKey: "dishtype_name") as? String
        dtAddedDate = aDecoder.decodeObject(forKey: "dt_added_date") as? String
        dtModifiedDate = aDecoder.decodeObject(forKey: "dt_modified_date") as? AnyObject
        flgAcStatus = aDecoder.decodeObject(forKey: "flg_ac_status") as? String
        flgAddChoices = aDecoder.decodeObject(forKey: "flg_add_choices") as? String
        flgApprovalStatus = aDecoder.decodeObject(forKey: "flg_approval_status") as? String
        flgDishType = aDecoder.decodeObject(forKey: "flg_dish_type") as? String
        flgIsDelete = aDecoder.decodeObject(forKey: "flg_is_delete") as? String
        flgPopularDish = aDecoder.decodeObject(forKey: "flg_popular_dish") as? String
        imageURL = aDecoder.decodeObject(forKey: "imageURL") as? String
        imagename = aDecoder.decodeObject(forKey: "imagename") as? String
        inChefId = aDecoder.decodeObject(forKey: "in_chef_id") as? String
        inCuisineId = aDecoder.decodeObject(forKey: "in_cuisine_id") as? String
        inDishId = aDecoder.decodeObject(forKey: "in_dish_id") as? String
        maxQtyPeruser = aDecoder.decodeObject(forKey: "max_qty_peruser") as? String
        outOfStock = aDecoder.decodeObject(forKey: "out_of_stock") as? String
        rejectReason = aDecoder.decodeObject(forKey: "reject_reason") as? String
        stAttributeName = aDecoder.decodeObject(forKey: "st_attribute_name") as? AnyObject
        stDishDesription = aDecoder.decodeObject(forKey: "st_dish_desription") as? String
        stDishName = aDecoder.decodeObject(forKey: "st_dish_name") as? String
        stPrice = aDecoder.decodeObject(forKey: "st_price") as? String
        stServingSize = aDecoder.decodeObject(forKey: "st_serving_size") as? String
        subCuisineId = aDecoder.decodeObject(forKey: "sub_cuisine_id") as? String
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if availablity != nil{
            aCoder.encode(availablity, forKey: "availablity")
        }
        if cookingTime != nil{
            aCoder.encode(cookingTime, forKey: "cooking_time")
        }
        if diettypeName != nil{
            aCoder.encode(diettypeName, forKey: "diettype_name")
        }
        if dishdiet != nil{
            aCoder.encode(dishdiet, forKey: "dishdiet")
        }
        if dishtypeName != nil{
            aCoder.encode(dishtypeName, forKey: "dishtype_name")
        }
        if dtAddedDate != nil{
            aCoder.encode(dtAddedDate, forKey: "dt_added_date")
        }
        if dtModifiedDate != nil{
            aCoder.encode(dtModifiedDate, forKey: "dt_modified_date")
        }
        if flgAcStatus != nil{
            aCoder.encode(flgAcStatus, forKey: "flg_ac_status")
        }
        if flgAddChoices != nil{
            aCoder.encode(flgAddChoices, forKey: "flg_add_choices")
        }
        if flgApprovalStatus != nil{
            aCoder.encode(flgApprovalStatus, forKey: "flg_approval_status")
        }
        if flgDishType != nil{
            aCoder.encode(flgDishType, forKey: "flg_dish_type")
        }
        if flgIsDelete != nil{
            aCoder.encode(flgIsDelete, forKey: "flg_is_delete")
        }
        if flgPopularDish != nil{
            aCoder.encode(flgPopularDish, forKey: "flg_popular_dish")
        }
        if imageURL != nil{
            aCoder.encode(imageURL, forKey: "imageURL")
        }
        if imagename != nil{
            aCoder.encode(imagename, forKey: "imagename")
        }
        if inChefId != nil{
            aCoder.encode(inChefId, forKey: "in_chef_id")
        }
        if inCuisineId != nil{
            aCoder.encode(inCuisineId, forKey: "in_cuisine_id")
        }
        if inDishId != nil{
            aCoder.encode(inDishId, forKey: "in_dish_id")
        }
        if maxQtyPeruser != nil{
            aCoder.encode(maxQtyPeruser, forKey: "max_qty_peruser")
        }
        if outOfStock != nil{
            aCoder.encode(outOfStock, forKey: "out_of_stock")
        }
        if rejectReason != nil{
            aCoder.encode(rejectReason, forKey: "reject_reason")
        }
        if stAttributeName != nil{
            aCoder.encode(stAttributeName, forKey: "st_attribute_name")
        }
        if stDishDesription != nil{
            aCoder.encode(stDishDesription, forKey: "st_dish_desription")
        }
        if stDishName != nil{
            aCoder.encode(stDishName, forKey: "st_dish_name")
        }
        if stPrice != nil{
            aCoder.encode(stPrice, forKey: "st_price")
        }
        if stServingSize != nil{
            aCoder.encode(stServingSize, forKey: "st_serving_size")
        }
        if subCuisineId != nil{
            aCoder.encode(subCuisineId, forKey: "sub_cuisine_id")
        }
        
    }
    
}



class SettingData {

    var baseDeliveryDistance : String!
    var baseDeliveryPrice : String!
    var creditCardFee : String!
    var deliveryCharge : String!
    var distance : String!
    var tax : String!
    var stripe_key : String!

    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        baseDeliveryDistance = dictionary["base_delivery_distance"] as? String
        baseDeliveryPrice = dictionary["base_delivery_price"] as? String
        creditCardFee = dictionary["credit_card_fee"] as? String
        deliveryCharge = dictionary["delivery_charge"] as? String
        distance = dictionary["distance"] as? String
        tax = dictionary["tax"] as? String
        stripe_key = dictionary["stripe_key"] as? String
        tokenStrip = stripe_key ?? ""
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if baseDeliveryDistance != nil{
            dictionary["base_delivery_distance"] = baseDeliveryDistance
        }
        if baseDeliveryPrice != nil{
            dictionary["base_delivery_price"] = baseDeliveryPrice
        }
        if creditCardFee != nil{
            dictionary["credit_card_fee"] = creditCardFee
        }
        if deliveryCharge != nil{
            dictionary["delivery_charge"] = deliveryCharge
        }
        if distance != nil{
            dictionary["distance"] = distance
        }
        if tax != nil{
            dictionary["tax"] = tax
        }
        return dictionary
    }

    
}
