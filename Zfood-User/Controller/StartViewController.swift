//
//  StartViewController.swift
 //
//  Created by bhavya on 8/26/19.
//  Copyright © 2019 WemakeAppz. All rights reserved.

import UIKit
class StartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
         checkogin()
    }
    func checkogin(){
        if UserDefaults.standard.value(forKey: Constants.userDefaults.userDetail) != nil{
          gotoLocationVC()
        }else{
            gotoLoginC()
        }
    }
    func gotoLocationVC(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
               appDelegate.setLocationViewController(forNoti: false)
    }
    func gotoLoginC(){
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SelectTypeViewController") as! SelectTypeViewController
         vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    func firstTimeuser(){
           if  UserDefaults.standard.value(forKey: Constants.userDefaults.firstTime) == nil{
               let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                                                                        let initialViewControlleripad = mainStoryboardIpad.instantiateViewController(withIdentifier: "walkthrughVC") as! walkthrughVC
                                                                            let nav = UINavigationController(rootViewController: initialViewControlleripad)
                                                                nav.navigationBar.isHidden = true
                                                                nav.modalPresentationStyle = .fullScreen
                      UserDefaults.standard.set(true, forKey: Constants.userDefaults.firstTime)
                                                                
                          self.present(nav, animated: true, completion: nil)

           }else{
            let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                                                                                  let initialViewControlleripad = mainStoryboardIpad.instantiateViewController(withIdentifier: "SelectTypeViewController") as! SelectTypeViewController
                                                                                      let nav = UINavigationController(rootViewController: initialViewControlleripad)
                                                                          nav.navigationBar.isHidden = true
                                                                          nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true, completion: nil)
        }
    }
   
}
