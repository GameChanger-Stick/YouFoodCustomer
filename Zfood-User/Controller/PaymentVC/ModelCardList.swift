
import Foundation

class ModelCARDLIST {

    var data : [CARDLIST]!
    var msg : String!
    var status : String!


    init(fromDictionary dictionary: [String:Any]){
        data = [CARDLIST]()
        if let dataArray = dictionary["data"] as? [[String:Any]]{
            for dic in dataArray{
                let value = CARDLIST(fromDictionary: dic)
                data.append(value)
            }
        }
        msg = dictionary["msg"] as? String
        status = dictionary["status"] as? String
    }

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
//
//    Data.swift
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class CARDLIST {

    var brand : String!
    var cardNo : String!
    var created : String!
    var customerId : String!
    var expDate : String!
    var expMonth : String!
    var id : String!
    var userId : String!
    var isSelected = false
var name = ""
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        brand = dictionary["brand"] as? String
        name = dictionary["name"] as? String ?? ""
        cardNo = dictionary["card_no"] as? String
        created = dictionary["created"] as? String
        customerId = dictionary["customer_id"] as? String
        expDate = dictionary["exp_date"] as? String
        expMonth = dictionary["exp_month"] as? String
        id = dictionary["id"] as? String
        userId = dictionary["user_id"] as? String
    }

    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if brand != nil{
            dictionary["brand"] = brand
        }
        if cardNo != nil{
            dictionary["card_no"] = cardNo
        }
        if created != nil{
            dictionary["created"] = created
        }
        if customerId != nil{
            dictionary["customer_id"] = customerId
        }
        if expDate != nil{
            dictionary["exp_date"] = expDate
        }
        if expMonth != nil{
            dictionary["exp_month"] = expMonth
        }
        if id != nil{
            dictionary["id"] = id
        }
        if userId != nil{
            dictionary["user_id"] = userId
        }
        return dictionary
    }

}
