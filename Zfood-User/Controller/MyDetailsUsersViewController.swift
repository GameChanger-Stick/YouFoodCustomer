//
//  MyDetailsUsersViewController.swift
//  Zfood-User
//
//  Created by bhavya on 8/30/19.
//  Copyright © 2019 WemakeAppz. All rights reserved.
//

import UIKit

class MyDetailsUsersViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func handleMenu(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        //    appDelegate.centerContainer?.toggle(MMDrawerSide.left, animated: true, completion: nil)
        appDelegate.drawerController.open(.left, animated: true, completion: nil)
    }
    
    
    @IBAction func btnChangePassword(_ sender: Any) {
        gotoChangePassVC()
    }
    
    
    @IBAction func handleProfile(_ sender: Any) {
        gotoprofileVC()
    }
    func gotoChangePassVC(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ChangePasswordViewController") as! ChangePasswordViewController
         vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    func gotoprofileVC(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ZUCProfileViewController") as! ZUCProfileViewController
        vc.type = "1"
         vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
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
