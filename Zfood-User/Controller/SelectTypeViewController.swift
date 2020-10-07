//
//  SelectTypeViewController.swift
//  Zfood-User
//
//  Created by bhavya on 8/5/20.
//  Copyright © 2020 WemakeAppz. All rights reserved.
//

import UIKit

class SelectTypeViewController: UIViewController {
    var window: UIWindow?
     //  let storyboard = UIStoryboard(name: "Main", bundle: nil)
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func handleCook(_ sender: Any) {
        if let url = URL(string: "zfChef://") {

            UIApplication.shared.open(url, options: [:]) { (status) in
                if !(status){
                    if let url = URL(string: "https://apps.apple.com/us/app/michef-cook/id1500765309") {
                                       UIApplication.shared.open(url)
                                   }
                }
            }
return
            if UIApplication.shared.canOpenURL(url){
                UIApplication.shared.open(url)

            }else{
                if let url = URL(string: "https://apps.apple.com/us/app/michef-cook/id1500765309") {
                    UIApplication.shared.open(url)
                }
            }
            }
        
        return
        let app = UIApplication.shared
        let bundleID = "zfChef://"
        if app.canOpenURL(URL(string: bundleID)!) {
          print("App is install and can be opened")
          let url = URL(string:bundleID)!
          if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
          } else {
            UIApplication.shared.openURL(url)
          }
        } else {
           if let url = URL(string: "https://apps.apple.com/us/app/michef-cook/id1500765309") {
                      UIApplication.shared.open(url)
                  }        }
       
        
        
    }
    
    
    @IBAction func handleCustoer(_ sender: Any) {
        firstTimeuser()

    }
    func firstTimeuser(){
           if  UserDefaults.standard.value(forKey: Constants.userDefaults.firstTime) == nil{
               let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                                                                        let initialViewControlleripad = mainStoryboardIpad.instantiateViewController(withIdentifier: "walkthrughVC") as! walkthrughVC
                                                                            let nav = UINavigationController(rootViewController: initialViewControlleripad)
                                                                nav.navigationBar.isHidden = true
                                                                nav.modalPresentationStyle = .fullScreen
                      UserDefaults.standard.set(true, forKey: Constants.userDefaults.firstTime)
                                                                
               window?.rootViewController = initialViewControlleripad
               window?.makeKeyAndVisible()
           }else{
            let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                                                                                  let initialViewControlleripad = mainStoryboardIpad.instantiateViewController(withIdentifier: "ZFULoginVC") as! ZFULoginVC
                                                                                      let nav = UINavigationController(rootViewController: initialViewControlleripad)
                                                                          nav.navigationBar.isHidden = true
                                                                          nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true, completion: nil)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
