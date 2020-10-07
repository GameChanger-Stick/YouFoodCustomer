//
//  Alert.swift
//  FavBites
//
//  Created by Rajesh Kumar on 16/09/17.
//  Copyright © 2017 Orem. All rights reserved.
//

import UIKit

var isAlertDone : Bool = true

class Alert: NSObject {

  typealias CompletionHandler = (() -> Swift.Void)?
    
    var isLoaderShow : Bool = false
  
  func showWarningAlert(withTitle title: String, withMessage message: String, inView view: UIViewController, completionHandler: CompletionHandler){


    
  }
	func OKAlertController(Message : String , alertMsg : String)  {
		let alert = UIAlertController.init(title: alertMsg, message: Message, preferredStyle: .alert)

		let Ok = UIAlertAction.init(title: "OK", style: .cancel) { (sender) in

		}
		alert.addAction(Ok)

		var topController = UIApplication.shared.keyWindow!.rootViewController!

		while ((topController.presentedViewController) != nil) {
			topController = topController.presentedViewController!;
		}

        
		topController.present(alert, animated:true, completion:nil)
        
		//        alert.present(alert, animated: true, completion: nil)

	}
    func OKAlertControllerCustom(Message : String,okText:String , alertMsg : String,okAction : @escaping ()->())  {
        let alert = UIAlertController.init(title: alertMsg, message: Message, preferredStyle: .alert)
        
        let Ok = UIAlertAction.init(title: okText, style: .default) { (sender) in
            okAction()
        }
        let cancel = UIAlertAction.init(title: "Cancel", style: .cancel) { (sender) in
        }
        alert.addAction(Ok)
        alert.addAction(cancel)
        var topController = UIApplication.shared.keyWindow!.rootViewController!
        while ((topController.presentedViewController) != nil) {
            topController = topController.presentedViewController!;
        }
        topController.present(alert, animated:true, completion:nil)
        //        alert.present(alert, animated: true, completion: nil)
        
    }
	func ToastAlertController(Message : String , alertMsg : String)  {

		let alert = UIAlertController.init(title: alertMsg, message: Message, preferredStyle: .alert)

		let when = DispatchTime.now() + 1.5
		DispatchQueue.main.asyncAfter(deadline: when)
		{
			// your code with delay
			alert.dismiss(animated: true, completion: nil)
			isAlertDone = true
		}

		var topController = UIApplication.shared.keyWindow!.rootViewController!

		while ((topController.presentedViewController) != nil) {
			topController = topController.presentedViewController!;

		}
		if isAlertDone == true{
			isAlertDone = false
		topController.present(alert, animated:true, completion:nil)
		}
		//        alert.present(alert, animated: true, completion: nil)

	}
    func showActionSheet(title : String, okTitle : String, cancelTitle : String, message : String, viewController : UIViewController, okAction : (()->())? = nil, cancelAction : (()->())? = nil) {
        let version:NSString = UIDevice.current.systemVersion as NSString;
        
        if  version.doubleValue >= 8 {
            let alert:UIAlertController = UIAlertController(title: title, message: message, preferredStyle:.alert)
            
//            alert.addAction(UIAlertAction(title: cancelTitle, style: .default, handler: { (action: UIAlertAction) in
//
//                if let _okAction = cancelAction {
//
//                    _okAction()
//                }
//            }))
            alert.addAction(UIAlertAction(title: okTitle, style: .default, handler: { (action: UIAlertAction) in
                
                if let _okAction = okAction {
                    
                    _okAction()
                }
            }))
            alert.addAction(UIAlertAction(title: "CANCEL", style: .cancel, handler: { (action: UIAlertAction) in
                
                if let _okAction = okAction {
                    
                    
                }
            }))
            viewController.present(alert, animated:true, completion:nil);
        }
    }

   func showWithCancelAndOk(title : String, okTitle : String, cancelTitle : String, message : String, viewController : UIViewController, okAction : (()->())? = nil, cancelAction : (()->())? = nil) {
        let version:NSString = UIDevice.current.systemVersion as NSString;
        
        if  version.doubleValue >= 8 {
            let alert:UIAlertController = UIAlertController(title: title, message: message, preferredStyle:.alert)
            
            alert.addAction(UIAlertAction(title: cancelTitle, style: .cancel, handler: { (action: UIAlertAction) in
                
                if let _okAction = cancelAction {
                    
                    _okAction()
                }
            }))
            alert.addAction(UIAlertAction(title: okTitle, style: .default, handler: { (action: UIAlertAction) in
                
                if let _okAction = okAction {
                    
                    _okAction()
                }
            }))
            viewController.present(alert, animated:true, completion:nil);
        }
    }

}
