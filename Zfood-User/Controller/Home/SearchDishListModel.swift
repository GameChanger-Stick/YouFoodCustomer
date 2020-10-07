
//
//    RootClass.swift
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class ModelSearchDishList {

    var dishlist : [Dishlist]!
    var status : String!
    var msg : String!

    init(fromDictionary dictionary: [String:Any]){
        dishlist = [Dishlist]()
        if let dishlistArray = dictionary["dishlist"] as? [[String:Any]]{
            for dic in dishlistArray{
                let value = Dishlist(fromDictionary: dic)
                dishlist.append(value)
            }
        }
        status = dictionary["status"] as? String
        msg = dictionary["msg"] as? String
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if dishlist != nil{
            var dictionaryElements = [[String:Any]]()
            for dishlistElement in dishlist {
                dictionaryElements.append(dishlistElement.toDictionary())
            }
            dictionary["dishlist"] = dictionaryElements
        }
        if status != nil{
            dictionary["status"] = status
        }
        return dictionary
    }


}

//
//    Dishlist.swift
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class Dishlist {

    var chefData : ChefInfo!
    var dishCuisineId : String!
    var flgAddChoices : String!
    var flgDishType : String!
    var image : String!
    var inChefId : String!
    var inDishId : String!
    var maxOrder : String!
    var minOrder : String!
    var restaurantCuisineId : String!
    var stAttributeName : AnyObject!
    var stCuisineName : String!
    var stDishName : String!
    var stPrice : String!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        if let chefDataData = dictionary["chef_data"] as? [String:Any]{
            chefData = ChefInfo(fromDictionary: chefDataData)
        }
        dishCuisineId = dictionary["dish_cuisine_id"] as? String
        flgAddChoices = dictionary["flg_add_choices"] as? String
        flgDishType = dictionary["flg_dish_type"] as? String
        image = dictionary["image"] as? String
        inChefId = dictionary["in_chef_id"] as? String
        inDishId = dictionary["in_dish_id"] as? String
        maxOrder = dictionary["max_order"] as? String
        minOrder = dictionary["min_order"] as? String
        restaurantCuisineId = dictionary["restaurant_cuisine_id"] as? String
        stAttributeName = dictionary["st_attribute_name"] as? AnyObject
        stCuisineName = dictionary["st_cuisine_name"] as? String
        stDishName = dictionary["st_dish_name"] as? String
        stPrice = dictionary["st_price"] as? String
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if chefData != nil{
            dictionary["chef_data"] = chefData.toDictionary()
        }
        if dishCuisineId != nil{
            dictionary["dish_cuisine_id"] = dishCuisineId
        }
        if flgAddChoices != nil{
            dictionary["flg_add_choices"] = flgAddChoices
        }
        if flgDishType != nil{
            dictionary["flg_dish_type"] = flgDishType
        }
        if image != nil{
            dictionary["image"] = image
        }
        if inChefId != nil{
            dictionary["in_chef_id"] = inChefId
        }
        if inDishId != nil{
            dictionary["in_dish_id"] = inDishId
        }
        if maxOrder != nil{
            dictionary["max_order"] = maxOrder
        }
        if minOrder != nil{
            dictionary["min_order"] = minOrder
        }
        if restaurantCuisineId != nil{
            dictionary["restaurant_cuisine_id"] = restaurantCuisineId
        }
        if stAttributeName != nil{
            dictionary["st_attribute_name"] = stAttributeName
        }
        if stCuisineName != nil{
            dictionary["st_cuisine_name"] = stCuisineName
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
