//
//  RateViewController.swift
//  Zfood-User
//
//  Created by bhavya on 9/20/19.
//  Copyright © 2019 WemakeAppz. All rights reserved.
//

import UIKit
import Cosmos
protocol RELOADORDER {
    func reloadORDER()
}
class RateViewController: UIViewController {
    
    @IBOutlet weak var txtComment: UITextView!
    @IBOutlet weak var rateView: CosmosView!
    var ordeDAta : Order?
    var delegate : RELOADORDER?
    let txt = "Enter your comment"
    override func viewDidLoad() {
        super.viewDidLoad()
        txtComment.text = txt
        txtComment.textColor = UIColor.lightGray
        // Do any additional setup after loading the view.
    }
    @IBAction func handleSubmit(_ sender: Any) {
         RateChef(loader:true)
    }

    @IBAction func handleCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func RateChef(loader:Bool){
        var comment : String{
            if self.txtComment.text == txt{
                return ""
            }else{
                return self.txtComment.text
            }
        }
        let rate = String(rateView.rating)
        let dict = ["userid":(currentUser?.info.inUserId)!,"chefid":self.ordeDAta?.chefdata.in_chef_id,"rule":"4","rating":rate,"order_num":self.ordeDAta?.orderNumber,"description":comment]
        APIServices().RateChef(params: dict as! [String : String], loader: true, viewController: self) { (result) in
            self.showSuccessWithBtn(msg: result?.msg ?? "", completion: {
                self.delegate?.reloadORDER()
                self.dismiss(animated: true, completion: nil)
            })
        }
    }
}
extension RateViewController : UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            txtComment.text = nil
            txtComment.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            txtComment.text = txt
            txtComment.textColor = UIColor.lightGray
        }
    }
}
