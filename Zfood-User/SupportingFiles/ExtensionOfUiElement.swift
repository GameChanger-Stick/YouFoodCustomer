//
//import Foundation
//import QuartzCore
//import UIKit
//
//// MARK: CUSTOM DESIGNABLE TEXT FIELD
///// Note: This is to underline the textfield with customized properties
//@IBDesignable class UnderlinedTextFld : UITextField {
//    
//    @IBInspectable var startColor: UIColor = UIColor.darkGray
//    @IBInspectable var placeholderColor: UIColor = UIColor.darkGray
//    @IBInspectable var placeholderText: String = ""
//
//    @nonobjc class func layerClass() -> AnyClass { return CAGradientLayer.self }
//    
//    @IBInspectable var borderWidth : CGFloat = 1.0
//    @IBInspectable var opacity : Float = 0.78
//    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        let border = CALayer()
//        border.frame = CGRect(x: 0, y: self.frame.size.height - borderWidth, width: self.frame.size.width, height: self.frame.size.height)
//        border.borderWidth = borderWidth
//        border.borderColor = startColor.cgColor
//        border.opacity = opacity
//        self.layer.addSublayer(border)
//        self.layer.masksToBounds = true
//        self.attributedPlaceholder = NSAttributedString(string: placeholderText,
//                                                               attributes: [NSAttributedString.Key.foregroundColor: placeholderColor])
//    }
//}
//
//@IBDesignable public class UIRoundButton: UIButton {
//    //    var shadowAdded: Bool = false
//    
//    @IBInspectable var borderColor: UIColor = UIColor.white {
//        didSet {
//            layer.borderColor = borderColor.cgColor
//        }
//    }
//    
//    @IBInspectable var borderWidth: CGFloat = 2.0 {
//        didSet {
//            layer.borderWidth = borderWidth
//        }
//    }
//    
//    override public func layoutSubviews() {
//        super.layoutSubviews()
//        clipsToBounds = true
//    }
//    
//    
//    @IBInspectable var cornerRadius: CGFloat = 0 {
//        didSet {
//            layer.cornerRadius = cornerRadius
//        }
//    }
//}
//
//@IBDesignable public class UIRoundLabel: UILabel {
//    //    var shadowAdded: Bool = false
//    
//    @IBInspectable var borderColor: UIColor = UIColor.white {
//        didSet {
//            layer.borderColor = borderColor.cgColor
//        }
//    }
//    
//    @IBInspectable var borderWidth: CGFloat = 1.0 {
//        didSet {
//            layer.borderWidth = borderWidth
//        }
//    }
//    
//    override public func layoutSubviews() {
//        super.layoutSubviews()
//        clipsToBounds = true
//    }
//    
//    
//    @IBInspectable var cornerRadius: CGFloat = 0 {
//        didSet {
//            layer.cornerRadius = cornerRadius
//        }
//    }
//}
//
//
//@IBDesignable public class UIRoundTextField: UITextField {
//    //    var shadowAdded: Bool = false
//    
//    @IBInspectable var borderColor: UIColor = UIColor.white {
//        didSet {
//            layer.borderColor = borderColor.cgColor
//        }
//    }
//    
//    @IBInspectable var borderWidth: CGFloat = 2.0 {
//        didSet {
//            layer.borderWidth = borderWidth
//        }
//    }
//    
//    override public func layoutSubviews() {
//        super.layoutSubviews()
//        clipsToBounds = true
//    }
//    
//    
//    @IBInspectable var cornerRadius: CGFloat = 0 {
//        didSet {
//            layer.cornerRadius = cornerRadius
//        }
//    }
//}
//
//
//@IBDesignable public class UIRoundView: UIView {
//    //    var shadowAdded: Bool = false
//    
//    @IBInspectable var borderColor: UIColor = UIColor.white {
//        didSet {
//            layer.borderColor = borderColor.cgColor
//        }
//    }
//    
//    @IBInspectable var borderWidth: CGFloat = 2.0 {
//        didSet {
//            layer.borderWidth = borderWidth
//        }
//    }
//    
//    override public func layoutSubviews() {
//        super.layoutSubviews()
//        clipsToBounds = true
//    }
//    
//    
//    @IBInspectable var cornerRadius: CGFloat = 0 {
//        didSet {
//            layer.cornerRadius = cornerRadius
//        }
//    }
//}
//
//@IBDesignable public class ShadowView: UIView {
//    
//    @IBInspectable var shadowOffset: CGSize = CGSize(width: 0, height: 2) {
//        didSet {
//            layer.shadowOffset = shadowOffset
//        }
//    }
//    
//    @IBInspectable var shadowRadius: CGFloat = 1 {
//        didSet {
//            layer.shadowRadius = shadowRadius
//        }
//    }
//    
//    @IBInspectable var shadowOpacity: Float = 0.5 {
//        didSet {
//            layer.shadowOpacity = shadowOpacity
//        }
//    }
//    
//    @IBInspectable var cornerRadius: CGFloat = 0 {
//        didSet {
//            layer.cornerRadius = cornerRadius
//        }
//    }
//    
//    override public func layoutSubviews() {
//        super.layoutSubviews()
//        layer.masksToBounds = false
//    }
//    
//}
//
//
//@IBDesignable public class UIRoundImageView: UIImageView {
//    //    var shadowAdded: Bool = false
//    
//    @IBInspectable var borderColor: UIColor = UIColor.white {
//        didSet {
//            layer.borderColor = borderColor.cgColor
//        }
//    }
//    
//    @IBInspectable var borderWidth: CGFloat = 1.0 {
//        didSet {
//            layer.borderWidth = borderWidth
//        }
//    }
//    
//    override public func layoutSubviews() {
//        super.layoutSubviews()
//        clipsToBounds = true
//    }
//    
//    
//    @IBInspectable var cornerRadius: CGFloat = 0 {
//        didSet {
//            layer.cornerRadius = cornerRadius
//        }
//    }
//}
//
extension UIViewController {
    
    func httpHelper() -> HTTPHelper {
        let fromUrl : HTTPHelper = HTTPHelper()
        return fromUrl
    }
    
    func setupStatusBarColor(isEnable: Bool) {
        //if let statusbar = UIApplication.shared.value(forKey: "statusBar") as? UIView {
           // statusbar.backgroundColor = (isEnable ? Color.statusbar : UIColor.clear)
       // }
    }

    
    // MARK: UIALERVIEW COMMON METHOD
    
    func alert(_ title : String?, message: String?) {
        let alert = UIAlertController(title: title!, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .default) { action in
        })
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: VALIDATION
    
    func isValidEmail(_ testStr:String) -> Bool {
        let emailRegEx = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        var isValid = Bool()
        isValid = emailTest.evaluate(with: testStr)
        if !isValid {
            let alert = UIAlertController(title: "Warning!", message: "Please enter a valid email address.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .default) { action in
            })
            self.present(alert, animated: true, completion: nil)
        } else {
            return isValid
        }
        return isValid
    }
    
    func validatePhoneNumber(_ value: String) -> Bool {
        let PHONE_REGEX = "^\\d{3}\\d{3}\\d{4}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let isValid =  phoneTest.evaluate(with: value)
        
        if !isValid {
            let alert = UIAlertController(title: "Warning!", message: "Please Enter a valid Mobile Number.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .default) { action in
            })
            self.present(alert, animated: true, completion: nil)
        } else {
            return isValid
        }
        return isValid
    }
    
    func isEmptyField(_ testStr : String, WithMessage : String) -> Bool {
        var isValid = Bool()
        if testStr.count > 0 {
            isValid = true
        } else {
            isValid = !true
            let alert = UIAlertController(title: "Warning!", message: "Please Enter a valid \(WithMessage)", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Fechar ou cancelar", style: .default) { action in
            })
            self.present(alert, animated: true, completion: nil)
        }
        return isValid
    }
    
}
func allSidesShadowMedium(_ view: UIView, color: UIColor) {
    let iconlayer: CALayer? = view.layer
    iconlayer?.shadowColor = color.cgColor
    iconlayer?.shadowOpacity = 1
    iconlayer?.shadowOffset = CGSize.zero
    iconlayer?.shadowRadius = 2
    iconlayer?.masksToBounds = false
}
func allSidesShadowLight(_ view: UIView, color: UIColor) {
    let iconlayer: CALayer? = view.layer
    iconlayer?.shadowColor = color.cgColor
    iconlayer?.shadowOpacity = 1
    iconlayer?.shadowOffset = CGSize.zero
    iconlayer?.shadowRadius = 1
    iconlayer?.masksToBounds = false
}
