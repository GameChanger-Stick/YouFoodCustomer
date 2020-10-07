//
//  LabelClass.swift
//  EatDiggerCustomer
//
//  Created by Ramneet Singh on 09/05/18.
//  Copyright © 2018 Ramneet Singh. All rights reserved.
//

import Foundation
import UIKit


public extension UIDevice {
    
    var iPhone: Bool {
        return UIDevice().userInterfaceIdiom == .phone
    }
    var iPad: Bool {
        return UIDevice().userInterfaceIdiom == .pad
    }
    
    enum ScreenType: String {
        case iPhone4
        case iPhone5
        case iPhone6
        case iPhone6Plus
        case iPhoneX
        case iPad
        case Unknown
    }
    
    var screenType: ScreenType {
        
        // guard iPhone else { return .Unknown}
        switch UIScreen.main.nativeBounds.height {
        case 960:
            return .iPhone4
        case 1136:
            return .iPhone5
        case 1334:
            return .iPhone6
        case 2208, 1920:
            return .iPhone6Plus
        case 2436:
            return .iPhoneX
        case 2048.0:
            return .iPad
        default:
            return .Unknown
        }
    }
}


class DynamicSizeLabel : UILabel {
    required init(coder aDecoder: (NSCoder?)) {
        super.init(coder: aDecoder!)!
      
        switch UIDevice().screenType {
        case .iPhone4, .iPhone5:  // iPhone 4 & iPhone 5
            self.font = UIFont(name: (self.font.fontName), size: font.pointSize - 2)
            break
        case .iPhone6:            // iPhone 6 & iPhone 7
            self.font = UIFont(name: (self.font.fontName), size: font.pointSize)
            break
        case .iPhone6Plus:        // iPhone 6 Plus & iPhone 7 Plus
            self.font = UIFont(name: (self.font.fontName), size: font.pointSize + 4)
            break
        case .iPhoneX:            // iPhone X
            self.font = UIFont(name: (self.font.fontName), size: font.pointSize)
            break
        case .iPad:               // iPad
            self.font = UIFont(name: (self.font.fontName), size: font.pointSize + 6)
            break
        default:
            break
        }
       
    }
}

class Dynamic_Greater_SizeLabel : UILabel {
    required init(coder aDecoder: (NSCoder?)) {
        super.init(coder: aDecoder!)!
        
        switch UIDevice().screenType {
        case .iPhone4, .iPhone5:  // iPhone 4 & iPhone 5
            self.font = UIFont(name: (self.font.fontName), size: font.pointSize - 2)
            break
        case .iPhone6:            // iPhone 6 & iPhone 7
            self.font = UIFont(name: (self.font.fontName), size: font.pointSize)
            break
        case .iPhone6Plus:        // iPhone 6 Plus & iPhone 7 Plus
            self.font = UIFont(name: (self.font.fontName), size: font.pointSize + 4)
            break
        case .iPhoneX:            // iPhone X
            self.font = UIFont(name: (self.font.fontName), size: font.pointSize)
            break
        case .iPad:               // iPad
            self.font = UIFont(name: (self.font.fontName), size: font.pointSize + 5)
            break
        default:
            break
        }
        
    }
}





class DynamicSizeTextField : UITextField {
    
    required init(coder aDecoder: (NSCoder?)) {
        super.init(coder: aDecoder!)!
        
        if tag == 1{
            self.cornerRadius = self.frame.size.height/2
        }
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder!,
                                                        attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        self.textColor = UIColor.black
        
        self.font = UIFont.init(name: "FertigoPro-Regular", size: 17)
        
        switch UIDevice().screenType {
        case .iPhone4, .iPhone5:  // iPhone 4 & iPhone 5
            self.font = UIFont.init(name: "FertigoPro-Regular", size: (font?.pointSize)! - 2)
            break
        case .iPhone6:            // iPhone 6 & iPhone 7
            self.font = UIFont.init(name: "FertigoPro-Regular", size: (font?.pointSize)!)
            break
        case .iPhone6Plus:        // iPhone 6 Plus & iPhone 7 Plus
            self.font = UIFont.init(name: "FertigoPro-Regular", size: (font?.pointSize)! + 4)
            break
        case .iPhoneX:            // iPhone X
            self.font =  UIFont.init(name: "FertigoPro-Regular", size: (font?.pointSize)!)
            break
        case .iPad:               // iPad
            self.font = UIFont.init(name: "FertigoPro-Regular", size: (font?.pointSize)! + 7)
            break
        default:
            break
        }
        
    }
}

class DynamicSizeWithImageCountryCodeTextField : UITextField  {
    @IBInspectable var Image : UIImage = #imageLiteral(resourceName: "login_logo_without_text"){
        didSet {
            updateView()
        }
    }
    var imgView : UIImageView?
    var paddingView : UIView?
    var textCode = UITextField()
    func updateView() {
         imgView = UIImageView.init(frame: CGRect.init(x: 12, y:  self.frame.size.height/6 , width: self.frame.size.height/2 , height: self.frame.size.height/2))
        if  UIDevice.modelName.contains("iPad"){
            imgView?.frame = CGRect.init(x: (self.frame.size.height - self.frame.size.height/2)/2, y:  (self.frame.size.height - self.frame.size.height/2)/2 , width: self.frame.size.height/2 , height: self.frame.size.height/2)
        }

        imgView?.image = Image
        imgView?.contentMode = .scaleToFill
        imgView?.clipsToBounds = true
        addSubview(imgView!)
    }
    func UpdateFrame() {
            imgView?.frame = CGRect.init(x: (self.frame.size.height - self.frame.size.height/2)/2, y:  (self.frame.size.height - self.frame.size.height/2)/2 , width: self.frame.size.height/2 , height: self.frame.size.height/2)
            paddingView = UIView(frame: CGRect.init(x: 0, y: 0, width : self.frame.size.height - 20  , height:self.frame.height))
            textCode = UITextField.init(frame: CGRect.init(x: (self.frame.size.height - self.frame.size.height/2) + self.frame.size.height/2 , y:   0, width: self.frame.size.height  + 50  , height: self.frame.size.height))
            textCode.placeholder = "Code"
            textCode.leftView = paddingView
        textCode.leftViewMode = UITextField.ViewMode.always
            textCode.textAlignment = .center
        
      
        leftView = textCode
        leftViewMode = UITextField.ViewMode.always

    }
    required init(coder aDecoder: (NSCoder?)) {
        super.init(coder: aDecoder!)!
      

        if tag == 1{
            self.cornerRadius = self.frame.size.height/2
        }
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder!,
                                                        attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        self.textColor = UIColor.black
        self.font = UIFont.init(name: Constants.FontFamilyName, size: 17)
        switch UIDevice().screenType {
        case .iPhone4, .iPhone5:  // iPhone 4 & iPhone 5
            self.font = UIFont.init(name: Constants.FontFamilyName, size: (font?.pointSize)! - 2)
            break
        case .iPhone6:            // iPhone 6 & iPhone 7
            self.font = UIFont.init(name: Constants.FontFamilyName, size: (font?.pointSize)!)
            break
        case .iPhone6Plus:        // iPhone 6 Plus & iPhone 7 Plus
            self.font = UIFont.init(name: Constants.FontFamilyName, size: (font?.pointSize)! + 4)
            break
        case .iPhoneX:            // iPhone X
            self.font =  UIFont.init(name: Constants.FontFamilyName, size: (font?.pointSize)!)
            break
        case .iPad:               // iPad
            self.font = UIFont.init(name: Constants.FontFamilyName, size: (font?.pointSize)! + 7)
            break
        default:
            break
        }
        
    }
    @IBAction func Code(_ sender: Any) {
        print("top")
    }

}
class CountryPicker: UIPickerView {
    
}
class DynamicSizeWithImageTextField23 : UITextField {
    @IBInspectable var Image : UIImage = #imageLiteral(resourceName: "ic_searech"){
        didSet {
            updateView()
        }
    }
    var imgView : UIImageView?
    var paddingView : UIView?
    
    func updateView() {
        imgView = UIImageView.init(frame: CGRect.init(x: 12, y:  self.frame.size.height/6 , width: self.frame.size.height/2 , height: self.frame.size.height/2))
        
        imgView?.image = Image
        imgView?.contentMode = .scaleToFill
        imgView?.clipsToBounds = true
        addSubview(imgView!)
    }
    func UpdateFrame() {
        //        if  UIDevice.modelName.contains("iPad"){
        imgView?.frame = CGRect.init(x: (self.frame.size.height - self.frame.size.height/2)/2, y:  (self.frame.size.height - self.frame.size.height/2)/2 , width: self.frame.size.height/2 , height: self.frame.size.height/2)
        paddingView = UIView(frame: CGRect.init(x: 0, y: 0, width :self.frame.size.height, height:self.frame.height))
        leftView = paddingView
        leftViewMode = UITextField.ViewMode.always
        //        }
    }
    required init(coder aDecoder: (NSCoder?)) {
        super.init(coder: aDecoder!)!
        
        if tag == 1{
            self.cornerRadius = self.frame.size.height/2
        }
        //        //self.attributedPlaceholder = NSAttributedString(string: self.placeholder!,
        //                                                        attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: UIColor.black])
        self.textColor = UIColor.lightGray
        
        self.font = UIFont.init(name: Constants.FontFamilyName, size: 17)
        
        switch UIDevice().screenType {
        case .iPhone4, .iPhone5:  // iPhone 4 & iPhone 5
            self.font = UIFont.init(name: Constants.FontFamilyName, size: (font?.pointSize)! - 2)
            break
        case .iPhone6:            // iPhone 6 & iPhone 7
            self.font = UIFont.init(name: Constants.FontFamilyName, size: (font?.pointSize)!)
            break
        case .iPhone6Plus:        // iPhone 6 Plus & iPhone 7 Plus
            self.font = UIFont.init(name: Constants.FontFamilyName, size: (font?.pointSize)! + 4)
            break
        case .iPhoneX:            // iPhone X
            self.font =  UIFont.init(name: Constants.FontFamilyName, size: (font?.pointSize)!)
            break
        case .iPad:               // iPad
            self.font = UIFont.init(name: Constants.FontFamilyName, size: (font?.pointSize)! + 7)
            break
        default:
            break
        }
        
    }
    
}
class DynamicSizeWithImageTextField : UITextField {
    @IBInspectable var Image : UIImage = #imageLiteral(resourceName: "ic_searech"){
        didSet {
            updateView()
        }
    }
    var imgView : UIImageView?
    var paddingView : UIView?
    
    func updateView() {
         imgView = UIImageView.init(frame: CGRect.init(x: 12, y:  self.frame.size.height/6 , width: self.frame.size.height/2 , height: self.frame.size.height/2))
       
        imgView?.image = Image
        imgView?.contentMode = .scaleToFill
        imgView?.clipsToBounds = true
        addSubview(imgView!)
    }
    func UpdateFrame() {
//        if  UIDevice.modelName.contains("iPad"){
            imgView?.frame = CGRect.init(x: (self.frame.size.height - self.frame.size.height/2)/2, y:  (self.frame.size.height - self.frame.size.height/2)/2 , width: self.frame.size.height/2 , height: self.frame.size.height/2)
            paddingView = UIView(frame: CGRect.init(x: 0, y: 0, width :self.frame.size.height, height:self.frame.height))
            leftView = paddingView
        leftViewMode = UITextField.ViewMode.always
//        }
    }
    required init(coder aDecoder: (NSCoder?)) {
        super.init(coder: aDecoder!)!
      
        if tag == 1{
            self.cornerRadius = self.frame.size.height/2
        }
//        //self.attributedPlaceholder = NSAttributedString(string: self.placeholder!,
//                                                        attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
         self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        self.textColor = UIColor.black
        
        self.font = UIFont.init(name: Constants.FontFamilyName, size: 17)
        
        switch UIDevice().screenType {
        case .iPhone4, .iPhone5:  // iPhone 4 & iPhone 5
            self.font = UIFont.init(name: Constants.FontFamilyName, size: (font?.pointSize)! - 2)
            break
        case .iPhone6:            // iPhone 6 & iPhone 7
            self.font = UIFont.init(name: Constants.FontFamilyName, size: (font?.pointSize)!)
            break
        case .iPhone6Plus:        // iPhone 6 Plus & iPhone 7 Plus
            self.font = UIFont.init(name: Constants.FontFamilyName, size: (font?.pointSize)! + 4)
            break
        case .iPhoneX:            // iPhone X
            self.font =  UIFont.init(name: Constants.FontFamilyName, size: (font?.pointSize)!)
            break
        case .iPad:               // iPad
            self.font = UIFont.init(name: Constants.FontFamilyName, size: (font?.pointSize)! + 7)
            break
        default:
            break
        }
        
    }
    
}

extension UILabel {
    @IBInspectable
    var rotation: Int {
        get {
            return 0
        } set {
            let radians = CGFloat(CGFloat(Double.pi) * CGFloat(newValue) / CGFloat(180.0))
            self.transform = CGAffineTransform(rotationAngle: radians)
        }
    }
}

class customLabelSize: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        customSize()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        customSize()
    }
    private func customSize() {
        
        
        
    }
}


