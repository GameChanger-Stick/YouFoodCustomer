//
//  ZFUSupportVC.swift
//  Zfood-User
//
//  Created by apple on 06/05/19.
//  Copyright © 2019 WemakeAppz. All rights reserved.
//

import UIKit

class ZFUSupportVC: CommonViewController {

    @IBOutlet weak var txtView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setupStatusBarColor(isEnable: true)
    }
    

    @IBAction func handleSubmit(_ sender: Any) {
        if txtView.text != ""{
            callaPI()
        }else{
             self.view.makeToast("Add message.")
        }
    }
    @IBAction func backButtonDidTap(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    func callaPI(){
        let dict = ["user_id":(currentUser?.info.inUserId)!,"message":self.txtView.text ?? ""]
                APIServices().supportAPI(params:dict ,loader:true, viewController: self) { (result) in
                    self.view.makeToast(result?.msg)
                    self.txtView.text = ""
                    
                }
    }


}
