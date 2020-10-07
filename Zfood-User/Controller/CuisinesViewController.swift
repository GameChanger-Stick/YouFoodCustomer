
//
//  CuisinesViewController.swift
//  Zfood-User
//
//  Created by bhavya on 9/5/19.
//  Copyright © 2019 WemakeAppz. All rights reserved.

import UIKit

class CuisinesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var cuisin : Cuisinedata?
    
    @IBOutlet weak var lbltitle: UILabel!
    var chefList : ModelChefList?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: UITABLEVIEWCELL_IDENTIFIRE.CHEF_LIST, bundle: nil), forCellReuseIdentifier: UITABLEVIEWCELL_IDENTIFIRE.CHEF_LIST)
        self.getChefList(loader: true)
        self.lbltitle.text = cuisin?.name
        notificationForfav()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
       
    }
   
    override func viewDidDisappear(_ animated: Bool) {
       // navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    @IBAction func handleBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func getChefList(loader:Bool){
        let param = ["name":"","price_min":"","price_max":"","dish_type":"","cuisine_id":self.cuisin?.id! ?? "","user_id":currentUser?.info.inUserId ?? ""] as [String : Any]
        APIServices().GET_CHEF_LIST(params: param, viewController: self, loader: loader) { (data, error) in
            self.chefList = data
            self.tableView.reloadData()
        }
    }
    func FavUnFavChef(status:String,chefId:String){
        let param = ["status":status,"chef_id":chefId,"user_id":currentUser?.info.inUserId ?? ""] as [String : Any]
        APIServices().Fav_API(params: param, viewController: self, loader: false) { (data, error) in
            //self.getFavChefList(loader: false)
        }
    }
    func notificationForfav(){
        NotificationCenter.default.addObserver(self, selector: #selector(self.notificationReceived(_:)), name: .favChef, object: nil)
    }
    
    @objc func notificationReceived(_ notification: Notification) {
        guard let id = notification.userInfo?["index"] as? Int else { return }
        guard let status = notification.userInfo?["status"] as? String else { return }
        self.FavUnFavChef(status: status, chefId: chefList?.chefInfo[id].inChefId ?? "")
    }

}

extension CuisinesViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return chefList?.chefInfo.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITABLEVIEWCELL_IDENTIFIRE.CHEF_LIST, for: indexPath) as! ChefListTableViewCell
       cell.getChef(detail: (chefList?.chefInfo[indexPath.row])!)
        cell.favoriteButton.tag = indexPath.row
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 230
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chefDetailsVC = self.storyboard?.instantiateViewController(withIdentifier: UIVIEWCONTROLLER_IDENTIFIRE.CHEF_DETAILS) as! ZFUChefDetailsVC
        GlofromSearchList = false
        chefDetailsVC.chefId = chefList?.chefInfo[indexPath.row].inChefId ?? ""
        let nv = UINavigationController(rootViewController: chefDetailsVC)
        self.navigationController?.pushViewController(chefDetailsVC, animated: true)
    }
}
