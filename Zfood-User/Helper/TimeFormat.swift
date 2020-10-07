//
//  TimeFormat.swift
//  SOC
//
//  Created by Apple on 18/01/18.
//  Copyright © 2018 OREM TECH. All rights reserved.
//
import UIKit

class TimeFormat: NSObject {

    func GetCurrentDate() -> String {
        let dateCurrent = Date()
        let formater = DateFormatter()
        formater.locale = Constants.DATE_FORMAT.localUS
        formater.dateFormat =  Constants.DATE_FORMAT.dateformattMain
        return formater.string(from: dateCurrent)
    }
    func GetCurrentDate1() -> String {
           let dateCurrent = Date()
           let formater = DateFormatter()
           formater.locale = Constants.DATE_FORMAT.localUS
           formater.dateFormat =  Constants.DATE_FORMAT.dateformattMain1
           return formater.string(from: dateCurrent)
       }
    
    func DateAfter(min:String) -> String{
        let dateFormatter = DateFormatter()
        let minInt : Int = min.IntValue()
        dateFormatter.dateFormat = Constants.DATE_FORMAT.dateformattMain
        dateFormatter.locale = Constants.DATE_FORMAT.localUS
        let newDate = Date().add(min: minInt)
       return dateFormatter.string(from: newDate)
    }

}
extension Date {
    
}
