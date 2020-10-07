//
//  AlertToast.swift
//  SNAP
//
//  Created by Jaypreet on 21/12/18.
//  Copyright © 2018 Jaypreet. All rights reserved.
//

import Foundation
import UIKit

class AlertToast : NSObject
{

     func MyToast(message:String , image : UIImage)
    {
        let Width = 300
        let Height = 90
        
        let mainView = UIView.init(frame:  CGRect.init(x: 0 , y: Int(UIScreen.main.bounds.height  + CGFloat(Height) + 100), width: Int(UIScreen.main.bounds.width), height: Height))
        mainView.backgroundColor = UIColor.clear
        mainView.alpha = 0
        mainView.alpha = 1
        
        let InerView = UIView.init(frame:  CGRect.init(x: 20 , y: 20 , width:  Int(mainView.frame.size.width - 40), height: Height - 20))
        InerView.backgroundColor = Constants.AppColor
        InerView.layer.cornerRadius = 8
        
        let AppImage = UIImageView.init(frame:  CGRect.init(x: 10, y: 10, width: 50, height: 50))
        AppImage.image = image
        
        let lblMessage = UILabel.init(frame:  CGRect.init(x: 70, y: 5, width: Width - 80, height: 60))
        lblMessage.text = message
        lblMessage.numberOfLines = 0
        lblMessage.textAlignment = .left
        lblMessage.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        lblMessage.minimumScaleFactor = 0.6
        
        if UIFont.init(name: Constants.FontFamilyName, size: 13) != nil{
            lblMessage.font = UIFont.init(name: Constants.FontFamilyName, size: 13)
        }
        else{
            lblMessage.font = UIFont.systemFont(ofSize: 13)
        }
        
        InerView.addSubview(lblMessage)
        InerView.addSubview(AppImage)
        mainView.addSubview(InerView)

        let clientApp = UIApplication.shared
        var windows = clientApp.windows
        var topWindow : UIWindow? = nil
        if windows.count != 0{
            topWindow = windows[0]
        }
        
        topWindow?.addSubview(mainView)
        mainView.animateToggleAlpha(status: "Show")
        
        let when = DispatchTime.now() + 2
        DispatchQueue.main.asyncAfter(deadline: when)
        {
            mainView.animateToggleAlpha(status: "Hide")
            let when = DispatchTime.now() + 1
            DispatchQueue.main.asyncAfter(deadline: when)
            {
                mainView.removeFromSuperview()
            }
        }
    }

}
extension UIView {
    
    func animateToggleAlpha(status : String) {
        UIView.animate(withDuration: 0.5) {
            let Height = 90

            if status == "Show"{
                self.frame.origin.y = (UIScreen.main.bounds.height  - CGFloat(Height) - 20)
            }
            else{
                self.frame.origin.y = (UIScreen.main.bounds.height  + CGFloat(Height) + 20)

            }
        }
    }
}
