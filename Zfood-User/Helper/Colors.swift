//
//  Colors.swift
//  EatDigger
//
//  Created by Ramneet Singh on 02/05/18.
//  Copyright © 2018 Ramneet Singh. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    class func main_Theme_Color() -> UIColor {
        return #colorLiteral(red: 0.1398892701, green: 0.6972202659, blue: 0.7770633101, alpha: 1)
        //return UIColor(red: 0/255.0, green: 37/255.0, blue: 146/255.0, alpha: 1.0)
    }
    class func systerBlue() -> UIColor {
        return #colorLiteral(red: 0, green: 0.4392156863, blue: 0.9607843137, alpha: 1)
        //return UIColor(red: 0/255.0, green: 37/255.0, blue: 146/255.0, alpha: 1.0)
    }
    
    class func light_Theme_Color() -> UIColor {
        return #colorLiteral(red: 0.1443719268, green: 0.7614886761, blue: 0.8481685519, alpha: 1)
        //return UIColor(red: 213/255.0, green: 169/255.0, blue: 247/255.0, alpha: 1.0)
    }
    
    class func Dark_Brown_Color() -> UIColor {
        return #colorLiteral(red: 0.7341641188, green: 0.6977167726, blue: 0.2462224066, alpha: 1)
        //return UIColor(red: 144/255.0, green: 102/255.0, blue: 212/255.0, alpha: 1.0)
    }
    
    class func textField_BG_Color() -> UIColor {
        return #colorLiteral(red: 0.1158661172, green: 0.7092120647, blue: 0.7894877791, alpha: 1)
        //return UIColor(red: 102/255.0, green: 204/255.0, blue: 0/255.0, alpha: 1.0)
    }
    
    class func navigation_Bar_Color() -> UIColor {
        return #colorLiteral(red: 0.09825115651, green: 0.6479485631, blue: 0.721754849, alpha: 1)
        //return UIColor(red: 177/255.0, green: 131/255.0, blue: 251/255.0, alpha: 1.0)
    }
    
    class func appTheam() -> UIColor {
        return #colorLiteral(red: 0.1480181813, green: 0.3486662209, blue: 0.8710603118, alpha: 1)
        //return UIColor(red: 177/255.0, green: 131/255.0, blue: 251/255.0, alpha: 1.0)
    }

    class func navigation_Bar_Color_Alfa() -> UIColor {
        //return #colorLiteral(red: 0.6940973997, green: 0.5244582295, blue: 0.9877430797, alpha: 0.5)
        return UIColor(red: 177/255.0, green: 131/255.0, blue: 251/255.0, alpha: 0.5)
    }
    
    class func status_Bar_Color() -> UIColor {
        return #colorLiteral(red: 0.07454860955, green: 0.5780765414, blue: 0.6480590701, alpha: 1)
        //return UIColor(red: 177/255.0, green: 131/255.0, blue: 251/255.0, alpha: 1.0)
    }
    
    class func waitingColor() -> UIColor {
        return UIColor.black.withAlphaComponent(0.5)
    }
    
    //let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
    //let blurEffectView = UIVisualEffectView(effect: blurEffect)
    //blurEffectView.frame = view.bounds
    //blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    //  view.addSubview(blurEffectView)
    
}
