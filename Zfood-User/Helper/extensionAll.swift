//
//  extensionAll.swift
//  IPay Customer
//
//  Created by Mukesh on 20/05/19.
//  Copyright © 2019 Jaypreet. All rights reserved.
//

import Foundation
import SCLAlertView
import UIKit
extension UIViewController{

    func showError(msg:String){
           _ = SCLAlertView().showError("Error", subTitle:msg, closeButtonTitle:"OK")
    }
    func showErrorGreen(msg:String){
        _ = SCLAlertView().showCustom(msg, subTitle: "", color: #colorLiteral(red: 0.2916116416, green: 0.6133737564, blue: 0, alpha: 1), icon: #imageLiteral(resourceName: "ic_card_number"))
    }
    
    func showSuccess(msg:String){
        _ = SCLAlertView().showSuccess("", subTitle: msg,colorStyle:UIColor().appColorYellow().rgb() ?? 0x22B573)
        
    }
    func showSuccessWithBtn(msg:String, completion : @escaping(()->())){
        let appearance = SCLAlertView.SCLAppearance(
            showCloseButton: false // hide default button
        )
        let alert = SCLAlertView(appearance: appearance) // create alert with appearance
        alert.addButton("OK", action: { // create button on alert
            completion()
        })
        alert.showSuccess(msg, subTitle: "")
        
    }
    func alertDismiss(){
    
    }
//    func UpdateUser(withCompletionHandler:@escaping (Bool) -> Void)  {
//        let dict = [
//            "id" : Constants.CurrentUserData.Id,
//            "userType" : "1"
//        ]
//        Constants.dataModel.getData(Url: Constants.API.POST_RegisterUser as NSString, dict: dict as NSDictionary, storyBoard: storyboard!, navigation: self) { (response, Error, Status) in
//            if Status == 200{
//                DataManager.CurrentUserData = response.value(forKey: "data")  as? [String : Any]
//                Constants.CurrentUserData = CurrentUser.init(userDetaildict: DataManager.CurrentUserData!)
//                withCompletionHandler(true)
//            }
//        }
//    withCompletionHandler(false)
//    }
}
extension UIView {
    /** Loads instance from nib with the same name. */
    func loadNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nibName = type(of: self).description().components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
    }
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}

extension UIColor{
    func appColorOrange()->UIColor{
        return #colorLiteral(red: 0.8846364021, green: 0.3896583915, blue: 0.2325494289, alpha: 1)
    }
    func appColorYellow()->UIColor{
        return #colorLiteral(red: 0.9581183791, green: 0.6791411042, blue: 0.006575286388, alpha: 1)
    }}

    extension UIColor {
        func rgb() -> UInt? {
            var fRed : CGFloat = 0
            var fGreen : CGFloat = 0
            var fBlue : CGFloat = 0
            var fAlpha: CGFloat = 0
            if self.getRed(&fRed, green: &fGreen, blue: &fBlue, alpha: &fAlpha) {
                let iRed = UInt(fRed * 255.0)
                let iGreen = UInt(fGreen * 255.0)
                let iBlue = UInt(fBlue * 255.0)
                let iAlpha = UInt(fAlpha * 255.0)
                //  (Bits 24-31 are alpha, 16-23 are red, 8-15 are green, 0-7 are blue).
                let rgb = (iAlpha << 24) + (iRed << 16) + (iGreen << 8) + iBlue
                return rgb
            } else {
                // Could not extract RGBA components:
                return nil
            }
        }
    }

extension Date {
    
    func getElapsedInterval() -> String {
        let interval = Calendar.current.dateComponents([.year, .month, .day], from: self, to: Date())
        if let year = interval.year, year > 0 {
            return year == 1 ? "\(year)" + " " + "year ago" :
                "\(year)" + " " + "years ago"
        } else if let month = interval.month, month > 0 {
            return month == 1 ? "\(month)" + " " + "month ago" :
                "\(month)" + " " + "months ago"
        } else if let day = interval.day, day > 0 {
            return day == 1 ? "\(day)" + " " + "day ago" :
                "\(day)" + " " + "days ago"
        } else {
            return "a moment ago"
        }
    }
    
    func add(min:Int) -> Date{
        let calendar = Calendar.current
        
        let date = calendar.date(byAdding: .minute, value: min, to: self)
        return date!
    }
    func isBetweeen(date date1: Date, andDate date2: Date) -> Bool {
        return date1.compare(self) == self.compare(date2)
    }
    func getDateIn(formatt:String)->String{
               let formater = DateFormatter()
               formater.locale = Constants.DATE_FORMAT.localUS
               formater.dateFormat =  formatt
               return formater.string(from: self)
        
    }
   
    func getNumberToCompareDate() -> String{
       let myCalendar = Calendar(identifier: .gregorian)
        let weekDay = myCalendar.component(.weekday, from: self)
        switch weekDay {
        case 1:
            return "7"
        case 2:
            return "1"
        case 3:
            return "2"
        case 4:
            return "3"
        case 5:
            return "4"
        case 6:
            return "5"
        case 7:
            return "6"
        default:
            return "Nada"
        }
    }
}

extension UIImageView{
    func getImage(url:String){
        if url == ""{
            self.image = UIImage(named: "noimage")
            return
        }
        self.sd_setImage(with: URL(string: url), placeholderImage: #imageLiteral(resourceName: "login_bg"), options: .continueInBackground) { (image, error, tyoee, urla) in
        }
        self.sd_setShowActivityIndicatorView(true)
        self.sd_setIndicatorStyle(.gray)
    }
}
extension String {
    func attributedStringWithColor(_ string: String, color: UIColor, characterSpacing: UInt? = nil) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
            let range = (self as NSString).range(of: string)
            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        guard let characterSpacing = characterSpacing else {return attributedString}
        attributedString.addAttribute(NSAttributedString.Key.kern, value: characterSpacing, range: NSRange(location: 0, length: attributedString.length))
        return attributedString
    }
}
extension Notification.Name {
    public static let favChef = Notification.Name(rawValue: "myNotificationKey1")
     public static let badgeNoti = Notification.Name(rawValue: "myNotificationKey3")
}
extension Int{
    func StringValue() -> String{
        return String(self)
    }
}
extension String{
    mutating func IntValue1() -> Int{
        self = self.components(separatedBy: ".")[0]
        return Int(self) ?? 0
    }
     func IntValue() -> Int{
       
        return Int(self) ?? 0
    }
    func IntValueNIL() -> Int?{
          
           return Int(self) ?? nil
       }
    func FloatValue() -> Float{
        return Float(self) ?? 0.0
    }
    
    func convertToDate() -> String{
        let dateCurrent = self
        let formater = DateFormatter()
        formater.locale = Constants.DATE_FORMAT.localUS
        formater.dateFormat =  Constants.DATE_FORMAT.dateformattMain
        if let sf =  formater.date(from: dateCurrent){
         formater.dateFormat =  Constants.DATE_FORMAT.datePickerTime
        return formater.string(from: sf)
        }
        return ""
    }
    
    func convertToDate90() -> String{
           let dateCurrent = self
           let formater = DateFormatter()
           formater.locale = Constants.DATE_FORMAT.localUS
           formater.dateFormat =  Constants.DATE_FORMAT.dateformattMain
           if let sf =  formater.date(from: dateCurrent){
            formater.dateFormat =  Constants.DATE_FORMAT.datePickerTime90
           return formater.string(from: sf)
           }
           return ""
       }
    func convertTo(format:String) -> String{
        let dateCurrent = self
        let formater = DateFormatter()
        formater.locale = Constants.DATE_FORMAT.localUS
        formater.dateFormat = Constants.DATE_FORMAT.dateformattMain
        if let sf =  formater.date(from: dateCurrent){
         formater.dateFormat =  format
        return formater.string(from: sf)
        }
        return ""
    }

    func convertTOFormat(from:String,to:String) -> String{
        let dateCurrent = self
        let formater = DateFormatter()
        formater.locale = Constants.DATE_FORMAT.localUS
        formater.dateFormat = from
        if let sf =  formater.date(from: dateCurrent){
         formater.dateFormat =  to
        return formater.string(from: sf)
        }
        return ""
    }
    func convertToMontht() -> String{
        let dateCurrent = self
        let formater = DateFormatter()
        formater.locale = Constants.DATE_FORMAT.localUS
        formater.dateFormat =  Constants.DATE_FORMAT.dateformattMain
        if let sf =  formater.date(from: dateCurrent){
            formater.dateFormat =  Constants.DATE_FORMAT.monthOnly
            return formater.string(from: sf)
        }
        return ""
    }

    func convertToDay() -> String{
        let dateCurrent = self
        let formater = DateFormatter()
        formater.locale = Constants.DATE_FORMAT.localUS
        formater.dateFormat =  Constants.DATE_FORMAT.dateformattMain
        if let sf =  formater.date(from: dateCurrent){
            formater.dateFormat =  Constants.DATE_FORMAT.dateOnly
            return formater.string(from: sf)
        }
        return ""
    }

    func withoutSpaces() -> String{
        return self.replacingOccurrences(of: " ", with: "%20")
    }
}
@IBDesignable class PaddingLabel: UILabel {
    @IBInspectable var topInset: CGFloat = 5.0
    @IBInspectable var bottomInset: CGFloat = 5.0
    @IBInspectable var leftInset: CGFloat = 7.0
    @IBInspectable var rightInset: CGFloat = 7.0
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets.init(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }
    
    //MARK: - It will set content size according to gives above four values
    override var intrinsicContentSize: CGSize {
        var intrinsicSuperViewContentSize = super.intrinsicContentSize
        intrinsicSuperViewContentSize.height += topInset + bottomInset
        intrinsicSuperViewContentSize.width += leftInset + rightInset
        return intrinsicSuperViewContentSize
    }
}
class TextField: UITextField {
    
    let padding = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}

extension UITableView {
    func scrollToBottom(){
        DispatchQueue.main.async {
            let indexPath = IndexPath(
                row: self.numberOfRows(inSection:  self.numberOfSections - 1) - 1,
                section: self.numberOfSections - 1)
            self.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
    
    func scrollToTop() {
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: 0, section: 0)
            self.scrollToRow(at: indexPath, at: .top, animated: false)
        }
    }
}
