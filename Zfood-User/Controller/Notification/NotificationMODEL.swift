//
//  NotificationMODEL.swift
//  Zfood-User
//
//  Created by bhavya on 2/5/20.
//  Copyright © 2020 WemakeAppz. All rights reserved.
//

import Foundation



class MODEL_NOTIFICATION{

    var data : [SingleNotificationModel]!
    var msg : String!
    var status : String!

    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        data = [SingleNotificationModel]()
        if let dataArray = dictionary["data"] as? [[String:Any]]{
            for dic in dataArray{
                let value = SingleNotificationModel(fromDictionary: dic)
                data.append(value)
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

}




class SingleNotificationModel{

    var chefId : String!
    var created : String!
    var descriptionField : String!
    var id : String!
    var modified : String!
    var title : String!
    var type : String!
    var userId : String!
    var img : String!
    var chefname : String!
    var userName : String!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        chefId = dictionary["in_chef_id"] as? String
        chefname = dictionary["chef_name"] as? String

        userName = dictionary["user_name"] as? String
        created = dictionary["created"] as? String
        descriptionField = dictionary["description"] as? String
        id = dictionary["id"] as? String
        modified = dictionary["modified"] as? String
        title = dictionary["title"] as? String
        type = dictionary["type"] as? String
        userId = dictionary["user_id"] as? String
        img = dictionary["img"] as? String
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if chefId != nil{
            dictionary["chef_id"] = chefId
        }
        if created != nil{
            dictionary["created"] = created
        }
        if descriptionField != nil{
            dictionary["description"] = descriptionField
        }
        if id != nil{
            dictionary["id"] = id
        }
        if modified != nil{
            dictionary["modified"] = modified
        }
        if title != nil{
            dictionary["title"] = title
        }
        if type != nil{
            dictionary["type"] = type
        }
        if userId != nil{
            dictionary["user_id"] = userId
        }
        return dictionary
    }
}
