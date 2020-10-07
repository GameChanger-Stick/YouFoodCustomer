
import UIKit
import CoreLocation

class MyCommonFunctionalUtilities: NSObject {
   
    // Below code to calculate if the Data taken from DB And Then converted to Modal Objects.

    class func isInternetCallTheApi() -> Bool {
        let status = Reach().connectionStatus()
        switch status {
        case .unknown, .offline:
            return false
        case .online(.wwan):
            return true
        case .online(.wiFi):
            return true
        }
    }
    
    class func checkForNull(data: AnyObject) -> String{
        let nul = NSNull()
        if data as! NSObject == nul {
            return ""
        }else {
            if let s_t_p = data as? NSNumber {
                return s_t_p.stringValue
            }
            return data as! String
        }
    }
    
    class func checkDecimalForNull(data: AnyObject) -> String {
        let nul = NSNull()
        if data as! NSObject == nul {
            return "0.00"
        }else {
            if let s_t_p = data as? NSNumber {
                return s_t_p.stringValue
            }
            return data as! String
        }
    }
    
    class func saveUserCurrentLocation(placemark: CLPlacemark) {
        if placemark.subLocality != nil {
            UserDefaults.standard.set(placemark.subLocality, forKey: "subLocality")
        }
        if placemark.thoroughfare != nil {
            UserDefaults.standard.set(placemark.thoroughfare, forKey: "thoroughfare")
        }
        if placemark.locality != nil {
            UserDefaults.standard.set(placemark.locality, forKey: "locality")
        }
        if placemark.country != nil {
            UserDefaults.standard.set(placemark.country, forKey: "country")
        }
        if placemark.postalCode != nil {
            UserDefaults.standard.set(placemark.postalCode, forKey: "postalCode")
        }
        if placemark.subThoroughfare != nil {
            UserDefaults.standard.set(placemark.subThoroughfare, forKey: "subThoroughfare")
        }
    }
    
    
}
