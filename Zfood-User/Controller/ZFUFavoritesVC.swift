//
//  ZFUFavoritesVC.swift
//  Zfood-User

//  Created by apple on 06/05/19.
//  Copyright © 2019 WemakeAppz. All rights reserved.
//
import UIKit

class ZFUFavoritesVC: UIViewController {
    var chefList : ModelChefList?
    @IBOutlet weak var chefListTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.chefListTableView.register(UINib(nibName: UITABLEVIEWCELL_IDENTIFIRE.HOME_HEADER, bundle: nil), forCellReuseIdentifier: UITABLEVIEWCELL_IDENTIFIRE.HOME_HEADER)
        self.chefListTableView.register(UINib(nibName: UITABLEVIEWCELL_IDENTIFIRE.CHEF_LIST_HEADER, bundle: nil), forCellReuseIdentifier: UITABLEVIEWCELL_IDENTIFIRE.CHEF_LIST_HEADER)
        self.chefListTableView.register(UINib(nibName: UITABLEVIEWCELL_IDENTIFIRE.CHEF_LIST, bundle: nil), forCellReuseIdentifier: UITABLEVIEWCELL_IDENTIFIRE.CHEF_LIST)
        self.notificationForfav()
        getFavChefList(loader: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setupStatusBarColor(isEnable: true)
         getFavChefList(loader: false)
    }

    @IBAction func backButtonDidTap(_ sender: UIButton) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        //    appDelegate.centerContainer?.toggle(MMDrawerSide.left, animated: true, completion: nil)
        appDelegate.drawerController.open(.left, animated: true, completion: nil)
    }
    
    func getFavChefList(loader:Bool){
        let param = ["user_id":currentUser?.info.inUserId ?? ""] as [String : Any]
        APIServices().GET_FAV_CHEF_LIST(params: param, viewController: self, loader: loader) { (data, error) in
            self.chefList = data
            self.chefListTableView.reloadData()
        }
    }
    
    func FavUnFavChef(status:String,chefId:String){
        let param = ["status":status,"chef_id":chefId,"user_id":currentUser?.info.inUserId ?? ""] as [String : Any]
        APIServices().Fav_API(params: param, viewController: self, loader: false) { (data, error) in
            self.view.makeToast(data?.msg, duration: 3.0, position: .bottom)
            self.getFavChefList(loader: false)
        }
    }
    
    func notificationForfav(){
        NotificationCenter.default.addObserver(self, selector: #selector(self.notificationReceived(_:)), name: .favChef, object: nil)
    }
    @objc func expandAvaibility(sender:UIButton) {
        if (chefList?.chefInfo[sender.tag].isexpand)!{
            chefList?.chefInfo[sender.tag].isexpand = false
        }else{
            chefList?.chefInfo[sender.tag].isexpand = true
        }
        self.chefListTableView.reloadData()
    }
    
    @objc func notificationReceived(_ notification: Notification) {
        guard let id = notification.userInfo?["index"] as? Int else { return }
        guard let status = notification.userInfo?["status"] as? String else { return }
        self.FavUnFavChef(status: status, chefId: chefList?.chefInfo[id].inChefId ?? "")
    }
}


extension ZFUFavoritesVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITABLEVIEWCELL_IDENTIFIRE.CHEF_LIST, for: indexPath) as! ChefListTableViewCell
               cell.btn_avaibility.tag = indexPath.row
               cell.btn_avaibility.addTarget(self, action: #selector(
                   self.expandAvaibility(sender:)), for: .touchUpInside)
        cell.favoriteButton.tag = indexPath.row
        cell.getChef(detail: (chefList?.chefInfo[indexPath.row])!)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.chefList?.chefInfo.count ?? 0
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
            let VC = self.storyboard?.instantiateViewController(withIdentifier: UIVIEWCONTROLLER_IDENTIFIRE.CheckYourAvailabiltyVC)
                        as! CheckYourAvailabiltyVC
            VC.chefID = chefList?.chefInfo[indexPath.row].inChefId ?? ""
             VC.openDays = chefList?.chefInfo[indexPath.row].availablity ?? ""
             VC.delegate = self
             VC.modalPresentationStyle = .overFullScreen
             self.present(VC, animated: false, completion: nil)
       
    }
}
extension ZFUFavoritesVC : GotoChefDetailDelegate{
//MARK:- GotoChefDetail

func gotoChefDetail(id: String) {
            let chefDetailsVC = self.storyboard?.instantiateViewController(withIdentifier: UIVIEWCONTROLLER_IDENTIFIRE.CHEF_DETAILS)as! ZFUChefDetailsVC
            chefDetailsVC.chefId = id
    GlofromSearchList = false
                  chefDetailsVC.modalPresentationStyle = .overFullScreen
                  self.present(chefDetailsVC, animated: true, completion: nil)
        }
}
    

