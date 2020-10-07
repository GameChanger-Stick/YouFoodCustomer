//
//  Constants.swift
//  FavBites
//
//  Created by jatin-pc on 8/30/17.
//  Copyright © 2017 Orem. All rights reserved.
//
import Foundation
import UIKit
var currencytype = String()
var MydeviceToken = String()
struct Constants {
    // Common Class
   // static let dataModel = DataModel()
    static let alert = Alert()
    static let Toast = AlertToast()
   // static let timeFormat = TimeFormat()
    
    static let checkTextField = CheckTextField()
    //static let userDefault = UserDefaults.standard
    static let Loader = ApiLoader()
    static let noDataFoundView = NoDataFoundView()
    static let kAppDelegate = UIApplication.shared.delegate as! AppDelegate
    // Common Font
    static let FontFamilyName = "IBMPlexSans-Medium"
    static let FontFamilyNameBold = "IBMPlexSans-Bold"
    static let Publishable_key = "pk_test_jsDUwmIQoi93G3HPfcDCJ1fo"
    // Common Header
    static let API_Header_Client_Service = "gorinse-client"
    static let API_Header_Auth_Key = "oremapi"
    static let PhoneCountryCode = "+971"
    // Common Time Format
    static let StrandredDateFormat = "yyyy-MM-dd HH:mm:ss ZZZZZ"
    static let StrandredDateFormatApi = "yyyy-MM-dd HH:mm:ss ZZZZZ"
    //static var DeviceToken = DataManager.device_token
    static let DeviceType = "ios"
    static let AppName = "Ipayd"
    static let AppLogo : UIImage  = #imageLiteral(resourceName: "onboard2")
    static let AppColor : UIColor  = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
    static let UserType = "1"
    static let CurrentLanguage = "1"
    static let ApiTimeOutTime = 5
    static let TimeIntervalForSlot = 30 * 60
    static var ApiToken : String  = UserDefaults.standard.value(forKey: "LoginToken") as! String
    static let GOOGLE_API_KEY = "AIzaSyBsbfQdyDSXJh6l7qIk6frxnelLds3yXsk"
    static let GOOGLE_CLIENT_ID = "516398872882-nchq2eviqvcis3b5mpej1brghuilmp3h.apps.googleusercontent.com"
    static var CurrentUserLat = ""
    static var CurrentUserLng = ""
   // static var CurrentUserData = CurrentUser.init(userDetaildict: (DataManager.CurrentUserData)!)
    
    struct userDefaults{
       static let userDetail = "userdetail"
        static let usrToken = "userdetail1"
        static let firstTime = "default1"
    }
    struct DATE_FORMAT{
        static let dateformattMain = "yyyy-MM-dd HH:mm:ss"
        static let dateformattMain1 = "MMMM dd,yyyy hh:mm a"
        static let datePickerTime = "dd MMM yyyy hh:mm a"
        static let datePickerTime90 = "MM-dd-yyyy HH:mm"
        static let ddmmyyyy = "dd/MMM/yyyy"
         static let onlyTime = "hh:mm a"
        static let dateOnly = "dd"
        static let EEEE = "EEEE"
        static let monthOnly = "MMM"
        static let localUS = Locale(identifier: "en_US_POSIX")
    }
    struct MESSAGE {
        // Common message
        static let EMPTY_FIRSTNAME =  "Please enter first name "
        static let EMPTY_LASTNAME = "Please enter last name"
        static let SOMETHING_Wrong  = "Something went wrong. Please try again."
        static let INTERNET_LOST  = "The Internet connection appears to be offline. Check Internet connection."
        static let NO_EVENT_FOUND  = "NO DATA FOUND"
        static let LOADING_DATA  = "LOADING DATA"
        static let LOGOUT  = "Would you like to logout from Account. Cart will automatically delete after Logout."
        static let LOGIN  = "'LOGIN' is required for this functionality."
        static let ProfileImage =  "Profile image is required for register."
        
        // Common Alert
        static let INVALID_EMAIL =  "Please enter the valid email address."
        static let EMPTY_Field =  "Please fill all required information."
        static let EMPTY_Country_Code_Field =  "Please select country code first."
        static let EMPTY =  "Please enter "
        static let closeResturent = "This resturent is closed."
        static let EMPTY_NAME =  "Please enter full name."
        static let EMPTY_Detail = "Please enter detail."
        static let EMPTY_Email =  "Please enter valid email address."
        static let EMPTY_Phone =  "Please enter valid phone number."
        static let EMPTY_Counrty_Code =  "Please enter valid Country Code."
        static let EMPTY_Otp =  "Please enter OTP. Sent on your number."
        static let Otp_Not_Match =  "OTP is not matched."
        static let EMPTY_Password =  "Please enter password atleast 6 digits."
        static let EMPTY_CONFIRMPASS =  "Please enter confirm password."
        static let EMPTY_Password_With_Space =  "Please enter password atlest-6 digits."
        static let EMPTY_Selecte_Date_first =  "Please select date first."
        static let EMPTY_RestaurantClose =  "Restaurant is close on this date, Choose any other day."
        static let FACEBOOK_NOT_ABLE_TO_LOGIN = "Sorry! Not able to login. Please try again."
        static let EMPTY_Password_match =  "Password not match."
        static let CheckTermAndConditon =  "Please Accept Terms & Conditions."
        static let CommonTextfieldMethod =  "Please enter "
        static let ClearCart  = "Your cart has items from another venue. Empty cart now to continue?"
        // Coustom message
        static let RemovePromoCode =  "Do you want to remove this promo code."
       // static let 
    }
    struct User_Type {
        static let CUSTOMER =  "5"
    }
    struct BUTTON {
        // Common Button
        static let REMOVE =  "Remove"
        static let APPLY =  "Apply"
        static let CANCEL =  "Cancel"
        static let NO =  "NO"
        static let YES =  "YES"
        static let Review =  "Review"
        static let Edit =  "EDIT"
        static let Submit =  "SUBMIT"
    }
    
    struct LOGIN_TYPE {
        static let EMAIL =  "0"
        static let FACEBOOK =  "1"
        static let GMAIL =  "3"
    }
    struct ORDER_TYPE {
        static let PICKUP =  "Pickup"
        static let TABLE =  "Table"
        static let ROOM =  "Room"
        static let SEAT =  "Seat"
        
    }
    struct API_ERROR_TYPE {
        static let API_CRASH =  "Error"
        static let NO_NETWORK =  "No Network"
        static let RE_Hit =  "Re hit"
        static let Success =  "Success"
        
    }
    struct Currency {
        static let doller =  "$"
        
        
    }
    struct MyOrderTableType {
        static let CurrentOrder =  "0"
        static let OrderHistory =  "1"
    }
    struct StatusSplitPayment {
        static let pending =  "0"
        static let accept =  "1"
        static let reject =  "2"
        
        static let paymentdone =  "3"
        
    }
    struct OrderStatus {
        
        static let Pending =  "0"
        static let Accepted =  "1"
        static let Inprogress =  "2"
        static let ontheway =  "3"
        static let complete =  "4"
        static let Rejected =  "5"
        static let Cancel =  "6"
        static let PendingString =  "Pending"
        static let AcceptedString =  "Accepted"
        static let InprogressString =  "In Progress"
        static let onthewayString =  "On The Way"
        static let completeString =  "Complete"
        static let RejectedString =  "Rejected"
        static let CancelString =  "Cancel"
        
    }
    
    struct VIEW_TITLE {
        // Common View Title
        static let cart = "Cart"
        static let shopingDetail = "Shoping detail"
         static let AddAddress = "Add Address"
        static let Payment = "Payment Detail"
        static let confirmOrder = "Confirm Order"
        static let REfine = "Refine"
        
    }
    
    struct VIEW_IDENTIFIER {
        // Common View Controller
        static let LoginViewController = "LoginViewController"
        static let SignUpViewController = "RegisterViewController"
        static let ForgotPasswordViewController = "ForgotPasswordViewController"
        static let TermsAndConditionsViewController = "TermsAndConditionsViewController"
        static let SettingViewController = "SettingViewController"
        static let HomeViewController = "HomeViewController"
        static let ChangePasswordViewController = "ChangePasswordViewController"
        static let ContactUsViewController = "ContactUsViewController"
        static let ProfileViewController = "ProfileViewController"
        static let HomeNavigationViewController = "HomeNavigationViewController"
        static let OTPViewController = "OtpViewController"
        static let TabViewController = "TabViewController"
        static let ReviewViewController = "ReviewViewController"
        // Custom View Controller
    }
    
    enum Language : String {
        case English = "1"
        case Arabic = "2"
    }
    
    struct API {
        //        http://oremtechnologies.com/zupdates/api/apis/getOtp?phone=9855004374&email=
        //        122.160.233.58
        // static var Server_URL = "https://appmantechnologies.com/himanshu/"
        static var Server_URL = "http://52.56.156.37/api/apis/"
        
        //        static var Server_URL = "http://122.160.233.58/himanshu/"
        static var BASE_URL = Server_URL //+ "ipay/api/apis/"
        static var IMAGE_BASE_URL = "http://52.56.156.37/"
        
        static let POST_Login : String = BASE_URL + "login"
        static let helpReasonList : String = BASE_URL + "helpReasonList"
        static let legalhelp : String = BASE_URL + "LegalHelp"
        //        helpReasonList
        static let POST_Logout : String = BASE_URL + "logout"
        static let POST_SendOTP : String = BASE_URL + "getOtp"
        static let POST_ForgotPassword : String = BASE_URL + "forgetPassword"
        static let POST_ChangePassword : String = BASE_URL + "changePassword"
        
        static let POST_RegisterUser : String = BASE_URL + "registerUser"
        static let POST_HOME : String = BASE_URL + "venueList"
        
        static let POST_ProfileUpdate : String = BASE_URL + "profileUpdate"
        static let POST_UserData : String = BASE_URL + "getUser"
        static let POST_term : String = BASE_URL + "page"
        static let POST_AdminData : String = BASE_URL + "getProfile"
        
        static let POST_AddPost : String = BASE_URL + "addPost"
        static let POST_MyPost : String = BASE_URL + "myPosts"
        static let POST_AllPost : String = BASE_URL + "getPosts"
        static let POST_UpdatePost : String = BASE_URL + "updatePost"
        static let POST_DeletePost : String = BASE_URL + "deletePost"
        static let POST_ReportPost : String = BASE_URL + "reportPost"
        static let POST_FavPost : String = BASE_URL + "addFavorite"
        static let POST_FavUser : String = BASE_URL + "favoriteUser"
        
        static let POST_CommentPost : String = BASE_URL + "commentPost"
        static let POST_PostDetail : String = BASE_URL + "postData"
        static let POST_ReportCommentPost : String = BASE_URL + "reportCommentPost"
        
        static let POST_CommentDelete : String = BASE_URL + "deleteComment"
        static let POST_AddCard : String = BASE_URL + "addCard"
        static let POST_EditCard : String = BASE_URL + "editCard"
        static let POST_CardList : String = BASE_URL + "listCard"
        static let POST_DeleteCard : String = BASE_URL + "deleteCard"
        
        static let POST_CheckPromoCode : String = BASE_URL + "check_promo"
        static let POST_AddOrder : String = BASE_URL + "addBooking"
        static let POST_MyOrder : String = BASE_URL + "bookingList"
        
        static let POST_VanueCatList : String = BASE_URL + "categoryList"
        static let POST_MakeFav : String = BASE_URL + "makeFav"
        static let POST_FavList : String = BASE_URL + "bookmarkList"
        static let POST_OfferList : String = BASE_URL + "custOfferList"
        static let POST_VenueDetail : String = BASE_URL + "venueDetail"
        
        static let POST_paymentRequest : String = BASE_URL + "paymentRequest"
        static let POST_paymentRequestList : String = BASE_URL + "paymentRequestList"
        static let POST_deletePaymentRequest : String = BASE_URL + "deletePaymentRequest"
        static let POST_paymentRequestAdd : String = BASE_URL + "paymentRequestAdd"
        static let POST_paymentRequestResend : String = BASE_URL + "paymentRequestResend"
        
        
        static let POST_PayPaymentRequest : String = BASE_URL + "PaymentRequestMakePayment"
        static let POST_RejectPaymentRequest : String = BASE_URL + "PaymentRequestReject"
        static let POST_AddRating : String = BASE_URL + "addRating"
        
        static let GET_LocationAddressApi =  "https://maps.googleapis.com/maps/api/geocode/json"
    }
    enum OrderStatus_Code : String {
        
        case Created = "Placed"
        case Verify = "Waiting For Conformation"
        case Accept = "In Kitchen"
        case Process = "In Process"
        case Ready = "Ready To Deliver"
        case Delivered = "Delivered"
        case Complete = "Complete"
        case Pending = "Payment Pending"
        case Cancel_by_customer = "Cancel by customer"
        case Cancel_By_Waiter = "Cancel By Waiter"
        case Cancel_By_Chef = "Cancel By Chef"
        func day() ->String {
            
            
            return self.rawValue
            
        }
        
    }
    
    
    static var countryDictionary  = ["AF":"93","AL":"355","DZ":"213","AS":"1","AD":"376","AO":"244",
                                     "AI":"1",
                                     "AG":"1",
                                     "AR":"54",
                                     "AM":"374",
                                     "AW":"297",
                                     "AU":"61",
                                     "AT":"43",
                                     "AZ":"994",
                                     "BS":"1",
                                     "BH":"973",
                                     "BD":"880",
                                     "BB":"1",
                                     "BY":"375",
                                     "BE":"32",
                                     "BZ":"501",
                                     "BJ":"229",
                                     "BM":"1",
                                     "BT":"975",
                                     "BA":"387",
                                     "BW":"267",
                                     "BR":"55",
                                     "IO":"246",
                                     "BG":"359",
                                     "BF":"226",
                                     "BI":"257",
                                     "KH":"855",
                                     "CM":"237",
                                     "CA":"1",
                                     "CV":"238",
                                     "KY":"345",
                                     "CF":"236",
                                     "TD":"235",
                                     "CL":"56",
                                     "CN":"86",
                                     "CX":"61",
                                     "CO":"57",
                                     "KM":"269",
                                     "CG":"242",
                                     "CK":"682",
                                     "CR":"506",
                                     "HR":"385",
                                     "CU":"53",
                                     "CY":"537",
                                     "CZ":"420",
                                     "DK":"45",
                                     "DJ":"253",
                                     "DM":"1",
                                     "DO":"1",
                                     "EC":"593",
                                     "EG":"20",
                                     "SV":"503",
                                     "GQ":"240",
                                     "ER":"291",
                                     "EE":"372",
                                     "ET":"251",
                                     "FO":"298",
                                     "FJ":"679",
                                     "FI":"358",
                                     "FR":"33",
                                     "GF":"594",
                                     "PF":"689",
                                     "GA":"241",
                                     "GM":"220",
                                     "GE":"995",
                                     "DE":"49",
                                     "GH":"233",
                                     "GI":"350",
                                     "GR":"30",
                                     "GL":"299",
                                     "GD":"1",
                                     "GP":"590",
                                     "GU":"1",
                                     "GT":"502",
                                     "GN":"224",
                                     "GW":"245",
                                     "GY":"595",
                                     "HT":"509",
                                     "HN":"504",
                                     "HU":"36",
                                     "IS":"354",
                                     "IN":"91",
                                     "ID":"62",
                                     "IQ":"964",
                                     "IE":"353",
                                     "IL":"972",
                                     "IT":"39",
                                     "JM":"1",
                                     "JP":"81",
                                     "JO":"962",
                                     "KZ":"77",
                                     "KE":"254",
                                     "KI":"686",
                                     "KW":"965",
                                     "KG":"996",
                                     "LV":"371",
                                     "LB":"961",
                                     "LS":"266",
                                     "LR":"231",
                                     "LI":"423",
                                     "LT":"370",
                                     "LU":"352",
                                     "MG":"261",
                                     "MW":"265",
                                     "MY":"60",
                                     "MV":"960",
                                     "ML":"223",
                                     "MT":"356",
                                     "MH":"692",
                                     "MQ":"596",
                                     "MR":"222",
                                     "MU":"230",
                                     "YT":"262",
                                     "MX":"52",
                                     "MC":"377",
                                     "MN":"976",
                                     "ME":"382",
                                     "MS":"1",
                                     "MA":"212",
                                     "MM":"95",
                                     "NA":"264",
                                     "NR":"674",
                                     "NP":"977",
                                     "NL":"31",
                                     "AN":"599",
                                     "NC":"687",
                                     "NZ":"64",
                                     "NI":"505",
                                     "NE":"227",
                                     "NG":"234",
                                     "NU":"683",
                                     "NF":"672",
                                     "MP":"1",
                                     "NO":"47",
                                     "OM":"968",
                                     "PK":"92",
                                     "PW":"680",
                                     "PA":"507",
                                     "PG":"675",
                                     "PY":"595",
                                     "PE":"51",
                                     "PH":"63",
                                     "PL":"48",
                                     "PT":"351",
                                     "PR":"1",
                                     "QA":"974",
                                     "RO":"40",
                                     "RW":"250",
                                     "WS":"685",
                                     "SM":"378",
                                     "SA":"966",
                                     "SN":"221",
                                     "RS":"381",
                                     "SC":"248",
                                     "SL":"232",
                                     "SG":"65",
                                     "SK":"421",
                                     "SI":"386",
                                     "SB":"677",
                                     "ZA":"27",
                                     "GS":"500",
                                     "ES":"34",
                                     "LK":"94",
                                     "SD":"249",
                                     "SR":"597",
                                     "SZ":"268",
                                     "SE":"46",
                                     "CH":"41",
                                     "TJ":"992",
                                     "TH":"66",
                                     "TG":"228",
                                     "TK":"690",
                                     "TO":"676",
                                     "TT":"1",
                                     "TN":"216",
                                     "TR":"90",
                                     "TM":"993",
                                     "TC":"1",
                                     "TV":"688",
                                     "UG":"256",
                                     "UA":"380",
                                     "AE":"971",
                                     "GB":"44",
                                     "US":"1",
                                     "UY":"598",
                                     "UZ":"998",
                                     "VU":"678",
                                     "WF":"681",
                                     "YE":"967",
                                     "ZM":"260",
                                     "ZW":"263",
                                     "BO":"591",
                                     "BN":"673",
                                     "CC":"61",
                                     "CD":"243",
                                     "CI":"225",
                                     "FK":"500",
                                     "GG":"44",
                                     "VA":"379",
                                     "HK":"852",
                                     "IR":"98",
                                     "IM":"44",
                                     "JE":"44",
                                     "KP":"850",
                                     "KR":"82",
                                     "LA":"856",
                                     "LY":"218",
                                     "MO":"853",
                                     "MK":"389",
                                     "FM":"691",
                                     "MD":"373",
                                     "MZ":"258",
                                     "PS":"970",
                                     "PN":"872",
                                     "RE":"262",
                                     "RU":"7",
                                     "BL":"590",
                                     "SH":"290",
                                     "KN":"1",
                                     "LC":"1",
                                     "MF":"590",
                                     "PM":"508",
                                     "VC":"1",
                                     "ST":"239",
                                     "SO":"252",
                                     "SJ":"47",
                                     "SY":"963",
                                     "TW":"886",
                                     "TZ":"255",
                                     "TL":"670",
                                     "VE":"58",
                                     "VN":"84",
                                     "VG":"284",
                                     "VI":"340"]  as NSDictionary
//    static var isplitDone : Bool {
//        if userDefault.value(forKey: "issplitdone") != nil{
//            return true
//        }
//        return false
//    }
    struct  FireBaseData {
        static let chatUrl = "https://zfooduser.firebaseio.com/"
        static let storageUrl = "gs://the-shop-app-228212.appspot.com/"
    }
}
public extension UIDevice {
    
    static let modelName: String = {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        func mapToDevice(identifier: String) -> String { // swiftlint:disable:this cyclomatic_complexity
            #if os(iOS)
            switch identifier {
            case "iPod5,1":                                 return "iPod Touch 5"
            case "iPod7,1":                                 return "iPod Touch 6"
            case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
            case "iPhone4,1":                               return "iPhone 4s"
            case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
            case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
            case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
            case "iPhone7,2":                               return "iPhone 6"
            case "iPhone7,1":                               return "iPhone 6 Plus"
            case "iPhone8,1":                               return "iPhone 6s"
            case "iPhone8,2":                               return "iPhone 6s Plus"
            case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
            case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
            case "iPhone8,4":                               return "iPhone SE"
            case "iPhone10,1", "iPhone10,4":                return "iPhone 8"
            case "iPhone10,2", "iPhone10,5":                return "iPhone 8 Plus"
            case "iPhone10,3", "iPhone10,6":                return "iPhone X"
            case "iPhone11,2":                              return "iPhone XS"
            case "iPhone11,4", "iPhone11,6":                return "iPhone XS Max"
            case "iPhone11,8":                              return "iPhone XR"
            case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
            case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
            case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
            case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
            case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
            case "iPad6,11", "iPad6,12":                    return "iPad 5"
            case "iPad7,5", "iPad7,6":                      return "iPad 6"
            case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
            case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
            case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
            case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
            case "iPad6,3", "iPad6,4":                      return "iPad Pro (9.7-inch)"
            case "iPad6,7", "iPad6,8":                      return "iPad Pro (12.9-inch)"
            case "iPad7,1", "iPad7,2":                      return "iPad Pro (12.9-inch) (2nd generation)"
            case "iPad7,3", "iPad7,4":                      return "iPad Pro (10.5-inch)"
            case "iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4":return "iPad Pro (11-inch)"
            case "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8":return "iPad Pro (12.9-inch) (3rd generation)"
            case "AppleTV5,3":                              return "Apple TV"
            case "AppleTV6,2":                              return "Apple TV 4K"
            case "AudioAccessory1,1":                       return "HomePod"
            case "i386", "x86_64":                          return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "iOS"))"
            default:                                        return identifier
            }
            #elseif os(tvOS)
            switch identifier {
            case "AppleTV5,3": return "Apple TV 4"
            case "AppleTV6,2": return "Apple TV 4K"
            case "i386", "x86_64": return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "tvOS"))"
            default: return identifier
            }
            #endif
        }
        
        return mapToDevice(identifier: identifier)
    }()
    
}

extension NotificationCenter{
   static let reloadOrderList = "reloadOrderList"
    static let openchefList = "reloadOrderList11"

}
