//
//  ZFUReviewVC.swift
//  Zfood-User
//
//  Created by Mukesh on 30/07/19.
//  Copyright © 2019 WemakeAppz. All rights reserved.
//

import UIKit

class ZFUReviewVC: UIViewController {
var fromMenu = false
    @IBOutlet var tableview: UITableView!
    
    @IBOutlet weak var btnBack: UIButton!
    var reviewList : MODELREVIEW?
    override func viewDidLoad() {
        super.viewDidLoad()
tableview.register(UINib(nibName: "ReviewTableViewCell", bundle: nil), forCellReuseIdentifier: "ReviewTableViewCell")
         ReviewAPI()
        if !fromMenu{
            self.btnBack.setImage(#imageLiteral(resourceName: "Path-gry"), for: .normal)
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func handleMenu(_ sender: Any) {
        if !fromMenu{
            self.dismiss(animated: true, completion: nil)
            return
        }
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        //    appDelegate.centerContainer?.toggle(MMDrawerSide.left, animated: true, completion: nil)
        appDelegate.drawerController.open(.left, animated: true, completion: nil)
    }
    func ReviewAPI(){
        APIServices().MY_Reviews(params: ["user_id":(currentUser?.info.inUserId)!], loader: true, viewController: self) { (result) in
           self.reviewList = result
            self.tableview.reloadData()
        }
    }
}

extension ZFUReviewVC : UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.reviewList?.info.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewTableViewCell", for: indexPath) as!ReviewTableViewCell
        cell.selectionStyle = .none
        cell.getData1(detail: self.reviewList?.info[indexPath.row])
        return cell
    }
    
    
}
