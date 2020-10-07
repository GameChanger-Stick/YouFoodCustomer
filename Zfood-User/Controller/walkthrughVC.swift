//
//  walkthrughVC.swift
//  Zfood-User
//
//  Created by bhavya on 3/9/20.
//  Copyright © 2020 WemakeAppz. All rights reserved.
//

import UIKit

class walkthrughVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func handleNext(_ sender: Any) {
        gotoLogin()
    }
    
    @IBAction func handleSki(_ sender: Any) {
        gotoLogin()
    }
    func gotoLogin(){
         let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                                                          let initialViewControlleripad = mainStoryboardIpad.instantiateViewController(withIdentifier: "SelectTypeViewController") as! SelectTypeViewController
                                                              let nav = UINavigationController(rootViewController: initialViewControlleripad)
                                                  nav.navigationBar.isHidden = true
                                                  nav.modalPresentationStyle = .fullScreen
        UserDefaults.standard.set(true, forKey: Constants.userDefaults.firstTime)
                                                  
        self.present(nav, animated: false, completion: nil)
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
