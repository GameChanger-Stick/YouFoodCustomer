//
//  ChatModel.swift
//  Dawene
//
//  Created by Jyoti Gupta on 11/06/18.
//  Copyright © 2018 Pal Singh. All rights reserved.
//

import Foundation

struct PrivateChatData
{
    
    var firstID : String!
    var firstImage : String!
    var firstName : String!
    var firstOnline : Bool!
    var lastFirstMessage : LastFirstMessage!
    var lastSecondMessage : LastFirstMessage!
    var secondID : String!
    var secondImage : String!
    var secondName : String!
    var secondOnline : Bool!
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        firstID = dictionary["firstID"] as? String
        firstImage = dictionary["firstImage"] as? String
        firstName = dictionary["firstName"] as? String
        firstOnline = dictionary["firstOnline"] as? Bool
        if let lastFirstMessageData = dictionary["lastFirstMessage"] as? [String:Any]{
            lastFirstMessage = LastFirstMessage(fromDictionary: lastFirstMessageData)
        }
        if let lastSecondMessageData = dictionary["lastSecondMessage"] as? [String:Any]{
            lastSecondMessage = LastFirstMessage(fromDictionary: lastSecondMessageData)
        }
        secondID = dictionary["secondID"] as? String
        secondImage = dictionary["secondImage"] as? String
        secondName = dictionary["secondName"] as? String
        secondOnline = dictionary["secondOnline"] as? Bool
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if firstID != nil{
            dictionary["firstID"] = firstID
        }
        if firstImage != nil{
            dictionary["firstImage"] = firstImage
        }
        if firstName != nil{
            dictionary["firstName"] = firstName
        }
        if firstOnline != nil{
            dictionary["firstOnline"] = firstOnline
        }
        if lastFirstMessage != nil{
            dictionary["lastFirstMessage"] = lastFirstMessage.toDictionary()
        }
        if lastSecondMessage != nil{
            dictionary["lastSecondMessage"] = lastSecondMessage.toDictionary()
        }
        if secondID != nil{
            dictionary["secondID"] = secondID
        }
        if secondImage != nil{
            dictionary["secondImage"] = secondImage
        }
        if secondName != nil{
            dictionary["secondName"] = secondName
        }
        if secondOnline != nil{
            dictionary["secondOnline"] = secondOnline
        }
        return dictionary
    }
    
}

struct LastFirstMessage{
    
    var availableFirst : Bool!
    var availableSecond : Bool!
    var file : Bool!
    var fileName : String!
    var fromUserID : String!
    var image : Bool!
    var message : String!
    var messageID : String!
    var timeStamp : String!
    var toUserID : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        availableFirst = dictionary["availableFirst"] as? Bool
        availableSecond = dictionary["availableSecond"] as? Bool
        file = dictionary["file"] as? Bool
        fileName = dictionary["fileName"] as? String
        fromUserID = dictionary["fromUserID"] as? String
        image = dictionary["image"] as? Bool
        message = dictionary["message"] as? String
        messageID = dictionary["messageID"] as? String
        timeStamp = dictionary["timeStamp"] as? String
        toUserID = dictionary["toUserID"] as? String
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if availableFirst != nil{
            dictionary["availableFirst"] = availableFirst
        }
        if availableSecond != nil{
            dictionary["availableSecond"] = availableSecond
        }
        if file != nil{
            dictionary["file"] = file
        }
        if fileName != nil{
            dictionary["fileName"] = fileName
        }
        if fromUserID != nil{
            dictionary["fromUserID"] = fromUserID
        }
        if image != nil{
            dictionary["image"] = image
        }
        if message != nil{
            dictionary["message"] = message
        }
        if messageID != nil{
            dictionary["messageID"] = messageID
        }
        if timeStamp != nil{
            dictionary["timeStamp"] = timeStamp
        }
        if toUserID != nil{
            dictionary["toUserID"] = toUserID
        }
        return dictionary
    }
}

//MARK: Selcted subject enum
public enum selectAddButton : Int
{
    case check = 1
    case uncheck = 0
}

struct ChatUserData
{
    var activationKey : String!
    var address : String!
    var age : String!
    var bio : String!
    var cCity : String!
    var cCountry : String!
    var cLat : String!
    var cLng : String!
    var cStreet : String!
    var chatStatus : String!
    var clinicFee : String!
    var clinicImage : String!
    var countryCode : String!
    var created : String!
    var dCity : String!
    var dCountry : String!
    var dStreet : String!
    var deviceToken : String!
    var deviceType : String!
    var doctorAvailable : String!
    var email : String!
    var emerStatus : String!
    var forgotKey : String!
    var gender : String!
    var homeFee : String!
    var id : String!
    var image : String!
    var insComp : String!
    var lang : String!
    var lat : String!
    var licenceImage : String!
    var limitDistance : String!
    var lng : String!
    var modified : String!
    var name : String!
    var occupation : String!
    var pass : String!
    var password : String!
    var phone : String!
    var pushStatus : String!
    var socialId : String!
    var socialType : String!
    var speciality : String!
    var status : String!
    var symptoms : String!
    var university : String!
    var userType : String!
    var username : String!
    var wallet : String!
    var workExp : String!
    var isSelected : selectAddButton
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        activationKey = dictionary["activationKey"] as? String
        address = dictionary["address"] as? String
        age = dictionary["age"] as? String
        bio = dictionary["bio"] as? String
        cCity = dictionary["c_city"] as? String
        cCountry = dictionary["c_country"] as? String
        cLat = dictionary["c_lat"] as? String
        cLng = dictionary["c_lng"] as? String
        cStreet = dictionary["c_street"] as? String
        chatStatus = dictionary["chat_status"] as? String
        clinicFee = dictionary["clinic_fee"] as? String
        clinicImage = dictionary["clinic_image"] as? String
        countryCode = dictionary["country_code"] as? String
        created = dictionary["created"] as? String
        dCity = dictionary["d_city"] as? String
        dCountry = dictionary["d_country"] as? String
        dStreet = dictionary["d_street"] as? String
        deviceToken = dictionary["deviceToken"] as? String
        deviceType = dictionary["deviceType"] as? String
        doctorAvailable = dictionary["doctor_available"] as? String
        email = dictionary["email"] as? String
        emerStatus = dictionary["emer_status"] as? String
        forgotKey = dictionary["forgot_key"] as? String
        gender = dictionary["gender"] as? String
        homeFee = dictionary["home_fee"] as? String
        id = dictionary["id"] as? String
        image = dictionary["image"] as? String
        insComp = dictionary["ins_comp"] as? String
        lang = dictionary["lang"] as? String
        lat = dictionary["lat"] as? String
        licenceImage = dictionary["licence_image"] as? String
        limitDistance = dictionary["limit_distance"] as? String
        lng = dictionary["lng"] as? String
        modified = dictionary["modified"] as? String
        name = dictionary["name"] as? String
        occupation = dictionary["occupation"] as? String
        pass = dictionary["pass"] as? String
        password = dictionary["password"] as? String
        phone = dictionary["phone"] as? String
        pushStatus = dictionary["push_status"] as? String
        socialId = dictionary["social_id"] as? String
        socialType = dictionary["social_type"] as? String
        speciality = dictionary["speciality"] as? String
        status = dictionary["status"] as? String
        symptoms = dictionary["symptoms"] as? String
        university = dictionary["university"] as? String
        userType = dictionary["userType"] as? String
        username = dictionary["username"] as? String
        wallet = dictionary["wallet"] as? String
        workExp = dictionary["work_exp"] as? String
        isSelected = .uncheck
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if activationKey != nil{
            dictionary["activationKey"] = activationKey
        }
        if address != nil{
            dictionary["address"] = address
        }
        if age != nil{
            dictionary["age"] = age
        }
        if bio != nil{
            dictionary["bio"] = bio
        }
        if cCity != nil{
            dictionary["c_city"] = cCity
        }
        if cCountry != nil{
            dictionary["c_country"] = cCountry
        }
        if cLat != nil{
            dictionary["c_lat"] = cLat
        }
        if cLng != nil{
            dictionary["c_lng"] = cLng
        }
        if cStreet != nil{
            dictionary["c_street"] = cStreet
        }
        if chatStatus != nil{
            dictionary["chat_status"] = chatStatus
        }
        if clinicFee != nil{
            dictionary["clinic_fee"] = clinicFee
        }
        if clinicImage != nil{
            dictionary["clinic_image"] = clinicImage
        }
        if countryCode != nil{
            dictionary["country_code"] = countryCode
        }
        if created != nil{
            dictionary["created"] = created
        }
        if dCity != nil{
            dictionary["d_city"] = dCity
        }
        if dCountry != nil{
            dictionary["d_country"] = dCountry
        }
        if dStreet != nil{
            dictionary["d_street"] = dStreet
        }
        if deviceToken != nil{
            dictionary["deviceToken"] = deviceToken
        }
        if deviceType != nil{
            dictionary["deviceType"] = deviceType
        }
        if doctorAvailable != nil{
            dictionary["doctor_available"] = doctorAvailable
        }
        if email != nil{
            dictionary["email"] = email
        }
        if emerStatus != nil{
            dictionary["emer_status"] = emerStatus
        }
        if forgotKey != nil{
            dictionary["forgot_key"] = forgotKey
        }
        if gender != nil{
            dictionary["gender"] = gender
        }
        if homeFee != nil{
            dictionary["home_fee"] = homeFee
        }
        if id != nil{
            dictionary["id"] = id
        }
        if image != nil{
            dictionary["image"] = image
        }
        if insComp != nil{
            dictionary["ins_comp"] = insComp
        }
        if lang != nil{
            dictionary["lang"] = lang
        }
        if lat != nil{
            dictionary["lat"] = lat
        }
        if licenceImage != nil{
            dictionary["licence_image"] = licenceImage
        }
        if limitDistance != nil{
            dictionary["limit_distance"] = limitDistance
        }
        if lng != nil{
            dictionary["lng"] = lng
        }
        if modified != nil{
            dictionary["modified"] = modified
        }
        if name != nil{
            dictionary["name"] = name
        }
        if occupation != nil{
            dictionary["occupation"] = occupation
        }
        if pass != nil{
            dictionary["pass"] = pass
        }
        if password != nil{
            dictionary["password"] = password
        }
        if phone != nil{
            dictionary["phone"] = phone
        }
        if pushStatus != nil{
            dictionary["push_status"] = pushStatus
        }
        if socialId != nil{
            dictionary["social_id"] = socialId
        }
        if socialType != nil{
            dictionary["social_type"] = socialType
        }
        if speciality != nil{
            dictionary["speciality"] = speciality
        }
        if status != nil{
            dictionary["status"] = status
        }
        if symptoms != nil{
            dictionary["symptoms"] = symptoms
        }
        if university != nil{
            dictionary["university"] = university
        }
        if userType != nil{
            dictionary["userType"] = userType
        }
        if username != nil{
            dictionary["username"] = username
        }
        if wallet != nil{
            dictionary["wallet"] = wallet
        }
        if workExp != nil{
            dictionary["work_exp"] = workExp
        }
        return dictionary
    }
}
extension Date {
    func currentTimeMillis() -> Int64! {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
}

