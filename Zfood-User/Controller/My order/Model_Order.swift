//
//    RootClass.swift
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class Model_MyOrder : NSObject, NSCoding{
    
    var msg : String!
    var order : [Order]!
    var status : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        msg = dictionary["msg"] as? String
        order = [Order]()
        if let orderArray = dictionary["order"] as? [[String:Any]]{
            for dic in orderArray{
                let value = Order(fromDictionary: dic)
                order.append(value)
            }
        }
        status = dictionary["status"] as? String
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if msg != nil{
            dictionary["msg"] = msg
        }
        if order != nil{
            var dictionaryElements = [[String:Any]]()
            for orderElement in order {
                dictionaryElements.append(orderElement.toDictionary())
            }
            dictionary["order"] = dictionaryElements
        }
        if status != nil{
            dictionary["status"] = status
        }
        return dictionary
    }
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        msg = aDecoder.decodeObject(forKey: "msg") as? String
        order = aDecoder.decodeObject(forKey :"order") as? [Order]
        status = aDecoder.decodeObject(forKey: "status") as? String
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if msg != nil{
            aCoder.encode(msg, forKey: "msg")
        }
        if order != nil{
            aCoder.encode(order, forKey: "order")
        }
        if status != nil{
            aCoder.encode(status, forKey: "status")
        }
    }
    
}


class Order : NSObject, NSCoding{
    
    var address : String!
    var address2 : String!
    var chefdata : Chefdata!
    var companyname : String!
    var deliveryCharge : String!
    var deliveryTime : String!
    var email : String!
    var fname : String!
    var id : String!
    var lat : String!
    var lname : String!
    var lng : String!
    var methodOfOrdering : String!
    var mobile : String!
    var nearestCrossCity : String!
    var orderAmount : String!
    var orderDate : String!
    var orderDetail : [OrderDetail]!
    var orderNumber : String!
    var orderStatus : String!
    var reject_reason = ""
    var orderType : String!
    var paymentMethod : String!
    var stVoucherAmount : String!
    var totalAmount : String!
    var transactionId : String!
    var voucherId : String!
    var wallet : String!
    var isOpen : Bool!
    var order_accepted_time : String!
    var order_rejected_time : String!
    var preparing_time : String!
    var ready_to_deliver_time : String!
    var on_the_way_time : String!
    var deliver_time : String!
    var cancel_customer_time : String!
    var startTimeDay : String!
     var startTimeMonth : String!
    var ratingdata : Ratingdata!
    var distance : String!
    var creditCardFee : String!
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        self.creditCardFee = dictionary["credit_card_fee"] as? String
        distance = dictionary["user_distance"] as! String
        let order_accept = dictionary["order_accepted_time"] as? String
        reject_reason = dictionary["cancel_reason"] as? String ??  ""
        let rejectTime = dictionary["order_rejected_time"] as? String
        let preparingTime = dictionary["preparing_time"] as? String
        let readyToDeliver = dictionary["ready_to_deliver_time"] as? String
        let ontheWAy = dictionary["on_the_way_time"] as? String
        let deliverTime = dictionary["delivery_time"] as? String
        if let ratingdataData = dictionary["ratingdata"] as? [String:Any]{
            ratingdata = Ratingdata(fromDictionary: ratingdataData)
        }
         let order_date = dictionary["order_date"] as? String
        startTimeDay = order_date?.convertToDay()
         startTimeMonth = order_date?.convertToMontht()
        order_accepted_time = order_accept?.convertToDate()
        order_rejected_time = rejectTime?.convertToDate()
        preparing_time = preparingTime?.convertToDate()
        ready_to_deliver_time = readyToDeliver?.convertToDate()
        on_the_way_time = ontheWAy?.convertToDate()
         deliver_time = deliverTime?.convertToDate()
         cancel_customer_time = dictionary["cancel_customer_time"] as? String
        address = dictionary["address"] as? String
        address2 = dictionary["address2"] as? String
        if let chefdataData = dictionary["chefdata"] as? [String:Any]{
            chefdata = Chefdata(fromDictionary: chefdataData)
        }
        isOpen = false
        companyname = dictionary["companyname"] as? String ?? ""
        deliveryCharge = dictionary["delivery_charge"] as? String
        if (self.deliveryCharge == ""){
            deliveryCharge = "0"
        }
        deliveryTime = deliverTime?.convertToDate90()
        email = dictionary["email"] as? String
        fname = dictionary["fname"] as? String
        id = dictionary["id"] as? String
        lat = dictionary["lat"] as? String
        lname = dictionary["lname"] as? String
        lng = dictionary["lng"] as? String
        methodOfOrdering = dictionary["method_of_ordering"] as? String
        mobile = dictionary["mobile"] as? String
        nearestCrossCity = dictionary["nearest_cross_city"] as? String ?? ""
        orderAmount = dictionary["order_amount"] as? String
       
        orderDate = order_date?.convertToDate90()
        orderDetail = [OrderDetail]()
        if let orderDetailArray = dictionary["order_detail"] as? [[String:Any]]{
            for dic in orderDetailArray{
                let value = OrderDetail(fromDictionary: dic)
                orderDetail.append(value)
            }
        }
        orderNumber = dictionary["order_number"] as? String
        orderStatus = dictionary["order_status"] as? String
        orderType = dictionary["order_type"] as? String
        paymentMethod = dictionary["payment_method"] as? String
        stVoucherAmount = dictionary["st_voucher_amount"] as? String
        totalAmount = dictionary["total_amount"] as? String
        transactionId = dictionary["transaction_id"] as? String ?? ""
        voucherId = dictionary["voucher_id"] as? String ?? ""
        wallet = dictionary["wallet"] as? String
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if address != nil{
            dictionary["address"] = address
        }
        if address2 != nil{
            dictionary["address2"] = address2
        }
        if chefdata != nil{
            dictionary["chefdata"] = chefdata.toDictionary()
        }
        if companyname != nil{
            dictionary["companyname"] = companyname
        }
        if deliveryCharge != nil{
            dictionary["delivery_charge"] = deliveryCharge
        }
        if deliveryTime != nil{
            dictionary["delivery_time"] = deliveryTime
        }
        if email != nil{
            dictionary["email"] = email
        }
        if fname != nil{
            dictionary["fname"] = fname
        }
        if id != nil{
            dictionary["id"] = id
        }
        if lat != nil{
            dictionary["lat"] = lat
        }
        if lname != nil{
            dictionary["lname"] = lname
        }
        if lng != nil{
            dictionary["lng"] = lng
        }
        if methodOfOrdering != nil{
            dictionary["method_of_ordering"] = methodOfOrdering
        }
        if mobile != nil{
            dictionary["mobile"] = mobile
        }
        if nearestCrossCity != nil{
            dictionary["nearest_cross_city"] = nearestCrossCity
        }
        if orderAmount != nil{
            dictionary["order_amount"] = orderAmount
        }
        if orderDate != nil{
            dictionary["order_date"] = orderDate
        }
        if orderDetail != nil{
            var dictionaryElements = [[String:Any]]()
            for orderDetailElement in orderDetail {
                dictionaryElements.append(orderDetailElement.toDictionary())
            }
            dictionary["order_detail"] = dictionaryElements
        }
        if orderNumber != nil{
            dictionary["order_number"] = orderNumber
        }
        if orderStatus != nil{
            dictionary["order_status"] = orderStatus
        }
        if orderType != nil{
            dictionary["order_type"] = orderType
        }
        if paymentMethod != nil{
            dictionary["payment_method"] = paymentMethod
        }
        if stVoucherAmount != nil{
            dictionary["st_voucher_amount"] = stVoucherAmount
        }
        if totalAmount != nil{
            dictionary["total_amount"] = totalAmount
        }
        if transactionId != nil{
            dictionary["transaction_id"] = transactionId
        }
        if voucherId != nil{
            dictionary["voucher_id"] = voucherId
        }
        if wallet != nil{
            dictionary["wallet"] = wallet
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        address = aDecoder.decodeObject(forKey: "address") as? String
        address2 = aDecoder.decodeObject(forKey: "address2") as? String
        chefdata = aDecoder.decodeObject(forKey: "chefdata") as? Chefdata
        companyname = aDecoder.decodeObject(forKey: "companyname") as? String ?? ""
        deliveryCharge = aDecoder.decodeObject(forKey: "delivery_charge") as? String
        deliveryTime = aDecoder.decodeObject(forKey: "delivery_time") as? String ?? ""
        email = aDecoder.decodeObject(forKey: "email") as? String
        fname = aDecoder.decodeObject(forKey: "fname") as? String
        id = aDecoder.decodeObject(forKey: "id") as? String
        lat = aDecoder.decodeObject(forKey: "lat") as? String
        lname = aDecoder.decodeObject(forKey: "lname") as? String
        lng = aDecoder.decodeObject(forKey: "lng") as? String
        methodOfOrdering = aDecoder.decodeObject(forKey: "method_of_ordering") as? String
        mobile = aDecoder.decodeObject(forKey: "mobile") as? String
        nearestCrossCity = aDecoder.decodeObject(forKey: "nearest_cross_city") as? String ?? ""
        orderAmount = aDecoder.decodeObject(forKey: "order_amount") as? String
        orderDate = aDecoder.decodeObject(forKey: "order_date") as? String
        orderDetail = aDecoder.decodeObject(forKey :"order_detail") as? [OrderDetail]
        orderNumber = aDecoder.decodeObject(forKey: "order_number") as? String
        orderStatus = aDecoder.decodeObject(forKey: "order_status") as? String
        orderType = aDecoder.decodeObject(forKey: "order_type") as? String
        paymentMethod = aDecoder.decodeObject(forKey: "payment_method") as? String
        stVoucherAmount = aDecoder.decodeObject(forKey: "st_voucher_amount") as? String
        totalAmount = aDecoder.decodeObject(forKey: "total_amount") as? String
        transactionId = aDecoder.decodeObject(forKey: "transaction_id") as? String ?? ""
        voucherId = aDecoder.decodeObject(forKey: "voucher_id")as? String ?? ""
        wallet = aDecoder.decodeObject(forKey: "wallet") as? String
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if address != nil{
            aCoder.encode(address, forKey: "address")
        }
        if address2 != nil{
            aCoder.encode(address2, forKey: "address2")
        }
        if chefdata != nil{
            aCoder.encode(chefdata, forKey: "chefdata")
        }
        if companyname != nil{
            aCoder.encode(companyname, forKey: "companyname")
        }
        if deliveryCharge != nil{
            aCoder.encode(deliveryCharge, forKey: "delivery_charge")
        }
        if deliveryTime != nil{
            aCoder.encode(deliveryTime, forKey: "delivery_time")
        }
        if email != nil{
            aCoder.encode(email, forKey: "email")
        }
        if fname != nil{
            aCoder.encode(fname, forKey: "fname")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if lat != nil{
            aCoder.encode(lat, forKey: "lat")
        }
        if lname != nil{
            aCoder.encode(lname, forKey: "lname")
        }
        if lng != nil{
            aCoder.encode(lng, forKey: "lng")
        }
        if methodOfOrdering != nil{
            aCoder.encode(methodOfOrdering, forKey: "method_of_ordering")
        }
        if mobile != nil{
            aCoder.encode(mobile, forKey: "mobile")
        }
        if nearestCrossCity != nil{
            aCoder.encode(nearestCrossCity, forKey: "nearest_cross_city")
        }
        if orderAmount != nil{
            aCoder.encode(orderAmount, forKey: "order_amount")
        }
        if orderDate != nil{
            aCoder.encode(orderDate, forKey: "order_date")
        }
        if orderDetail != nil{
            aCoder.encode(orderDetail, forKey: "order_detail")
        }
        if orderNumber != nil{
            aCoder.encode(orderNumber, forKey: "order_number")
        }
        if orderStatus != nil{
            aCoder.encode(orderStatus, forKey: "order_status")
        }
        if orderType != nil{
            aCoder.encode(orderType, forKey: "order_type")
        }
        if paymentMethod != nil{
            aCoder.encode(paymentMethod, forKey: "payment_method")
        }
        if stVoucherAmount != nil{
            aCoder.encode(stVoucherAmount, forKey: "st_voucher_amount")
        }
        if totalAmount != nil{
            aCoder.encode(totalAmount, forKey: "total_amount")
        }
        if transactionId != nil{
            aCoder.encode(transactionId, forKey: "transaction_id")
        }
        if voucherId != nil{
            aCoder.encode(voucherId, forKey: "voucher_id")
        }
        if wallet != nil{
            aCoder.encode(wallet, forKey: "wallet")
        }
        
    }
    
}


class OrderDetail : NSObject, NSCoding{
    
    var dishid : String!
    var dishname : String!
    var price : String!
    var qty : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        dishid = dictionary["dishid"] as? String ?? ""
        dishname = dictionary["dishname"] as? String ?? ""
        price = dictionary["price"] as? String ?? ""
        qty = dictionary["qty"] as? String ?? ""
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if dishid != nil{
            dictionary["dishid"] = dishid
        }
        if dishname != nil{
            dictionary["dishname"] = dishname
        }
        if price != nil{
            dictionary["price"] = price
        }
        if qty != nil{
            dictionary["qty"] = qty
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        dishid = aDecoder.decodeObject(forKey: "dishid") as? String ?? ""
        dishname = aDecoder.decodeObject(forKey: "dishname") as? String ?? ""
        price = aDecoder.decodeObject(forKey: "price") as? String ?? ""
        qty = aDecoder.decodeObject(forKey: "qty") as? String ?? ""
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if dishid != nil{
            aCoder.encode(dishid, forKey: "dishid")
        }
        if dishname != nil{
            aCoder.encode(dishname, forKey: "dishname")
        }
        if price != nil{
            aCoder.encode(price, forKey: "price")
        }
        if qty != nil{
            aCoder.encode(qty, forKey: "qty")
        }
        
    }
    
}

class Chefdata : NSObject, NSCoding{
    
    var address1 : String!
    var address2 : String!
    var firstname : String!
    var lastname : String!
    var lat : String!
    var lng : String!
    var in_chef_id : String!
    var stRestaurantName : String!
    var mobile : String!
    var smallAddress : String!
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        mobile = dictionary["mobile"] as? String
        in_chef_id = dictionary["in_chef_id"] as? String
        address1 = dictionary["address1"] as? String
        address2 = dictionary["address2"] as? String
        firstname = dictionary["firstname"] as? String
        lastname = dictionary["lastname"] as? String
        lat = dictionary["lat"] as? String
        lng = dictionary["lng"] as? String
        stRestaurantName = dictionary["st_restaurant_name"] as? String
        smallAddress = dictionary["small_address"] as? String
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if address1 != nil{
            dictionary["address1"] = address1
        }
        if address2 != nil{
            dictionary["address2"] = address2
        }
        if firstname != nil{
            dictionary["firstname"] = firstname
        }
        if lastname != nil{
            dictionary["lastname"] = lastname
        }
        if lat != nil{
            dictionary["lat"] = lat
        }
        if lng != nil{
            dictionary["lng"] = lng
        }
        if stRestaurantName != nil{
            dictionary["st_restaurant_name"] = stRestaurantName
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        address1 = aDecoder.decodeObject(forKey: "address1") as? String
        address2 = aDecoder.decodeObject(forKey: "address2") as? String
        firstname = aDecoder.decodeObject(forKey: "firstname") as? String
        lastname = aDecoder.decodeObject(forKey: "lastname") as? String
        lat = aDecoder.decodeObject(forKey: "lat") as? String
        lng = aDecoder.decodeObject(forKey: "lng") as? String
        stRestaurantName = aDecoder.decodeObject(forKey: "st_restaurant_name") as? String
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if address1 != nil{
            aCoder.encode(address1, forKey: "address1")
        }
        if address2 != nil{
            aCoder.encode(address2, forKey: "address2")
        }
        if firstname != nil{
            aCoder.encode(firstname, forKey: "firstname")
        }
        if lastname != nil{
            aCoder.encode(lastname, forKey: "lastname")
        }
        if lat != nil{
            aCoder.encode(lat, forKey: "lat")
        }
        if lng != nil{
            aCoder.encode(lng, forKey: "lng")
        }
        if stRestaurantName != nil{
            aCoder.encode(stRestaurantName, forKey: "st_restaurant_name")
        }
        
    }
    
}


class Ratingdata{
    
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
    var stFoodRating : String!
    var stOrderNum : String!
    var stReviewResponse : String!
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        dtAddedDate = dictionary["dt_added_date"] as? String
        dtModifiedDate = dictionary["dt_modified_date"] as? String
        flgAcStatus = dictionary["flg_ac_status"] as? String ?? ""
        flgApproveStatus = dictionary["flg_approve_status"] as? String
        flgIsDelete = dictionary["flg_is_delete"] as? String
        flgReviewResponse = dictionary["flg_review_response"] as? String
        inChefId = dictionary["in_chef_id"] as? String
        inId = dictionary["in_id"] as? String
        inUserId = dictionary["in_user_id"] as? String
        rule = dictionary["rule"] as? String
        stDescription = dictionary["st_description"] as? String ?? ""
        stFoodRating = dictionary["st_food_rating"] as? String
        stOrderNum = dictionary["st_order_num"] as? String
        stReviewResponse = dictionary["st_review_response"] as? String ?? ""
    }
    
   
}
