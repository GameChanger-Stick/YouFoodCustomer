//
//  CustomMethods.swift
//  EatDigger
//
//  Created by Ramneet Singh on 02/05/18.
//  Copyright © 2018 Ramneet Singh. All rights reserved.
//

import Foundation


import UIKit

var singletonObject: CustomMethods? = nil


class CustomMethods: NSObject {
    
    class func someTypeMethod()-> CustomMethods {
        //body
        if singletonObject == nil {
            singletonObject = CustomMethods()
        }
        
        return singletonObject!
    }
    
    
    class func appDelegate() -> AppDelegate {
        let appDelegate = (UIApplication.shared.delegate! as! AppDelegate)
        return appDelegate
    }
    
    
    func getCountryName(from countryCode: String) -> String {
        if let name = (Locale.current as NSLocale).displayName(forKey: .countryCode, value: countryCode) {
            return name
        } else {
            return ""
        }
    }
   
   
    
    class func createProgressRing(_ viewController: UIViewController) -> UIActivityIndicatorView {
        var mSpinner: UIActivityIndicatorView?
        mSpinner = UIActivityIndicatorView(style: .gray)
        let size = UIScreen.main.bounds.size
        mSpinner!.center = CGPoint(x: size.width / 2.0, y: size.height / 2.0)
        viewController.view.addSubview(mSpinner!)
        return mSpinner!
    }
    
    
    
    class func addSubview(_ subView: UIView, toView parentView: UIView)
    {
        parentView.addSubview(subView)
        let views = ["subView": subView]
        var constraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|[subView]|", options: [], metrics: nil, views: views)
        parentView.addConstraints(constraints)
        constraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|[subView]|", options: [], metrics: nil, views: views)
        parentView.addConstraints(constraints)
    }
}
class IntrinsicTableView: UITableView {
    
    override var contentSize:CGSize {
        didSet {
            self.invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        self.layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }
    
}
