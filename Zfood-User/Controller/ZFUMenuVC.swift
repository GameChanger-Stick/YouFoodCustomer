//
//  ZFUMenuVC.swift
//  Zfood-User
//
//  Created by apple on 06/05/19.
//  Copyright © 2019 WemakeAppz. All rights reserved.

import UIKit

class ZFUMenuVC: CommonViewController {

    @IBOutlet weak var menuTableView: UITableView!
    
    @IBOutlet weak var guestView: UIView!
    var selectedindex = -1
    override func viewDidLoad() {
        super.viewDidLoad()
        self.checkUser()
        // Do any additional setup after loading the view.
        self.menuTableView.register(UINib(nibName: UITABLEVIEWCELL_IDENTIFIRE.MENU, bundle: nil), forCellReuseIdentifier: UITABLEVIEWCELL_IDENTIFIRE.MENU)
        self.menuTableView.register(UINib(nibName: UITABLEVIEWCELL_IDENTIFIRE.MENU_HEADER, bundle: nil), forCellReuseIdentifier: UITABLEVIEWCELL_IDENTIFIRE.MENU_HEADER)
        NotificationCenter.default.addObserver(
                  self,
                  selector: #selector(self.checkUser),
                  name:Notification.Name("MenuUser"),
                  object: nil)
    }
    @IBAction func handleLogin(_ sender: Any) {
        let login = self.storyboard?.instantiateViewController(withIdentifier: UIVIEWCONTROLLER_IDENTIFIRE.ZFULoginVC) as! ZFULoginVC
                                                     login.modalPresentationStyle = .fullScreen
                                                     self.present(login, animated: true, completion: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        self.menuTableView.reloadData()
        selectedindex = -1
        self.navigationController?.isNavigationBarHidden = true
        self.setupStatusBarColor(isEnable: true)
    }
    @objc func checkUser(){
        if isguest{
                   guestView.isHidden = false
               }else{
                     guestView.isHidden = true
               }
    }
}

extension ZFUMenuVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MENU.menuTitleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: UITABLEVIEWCELL_IDENTIFIRE.MENU_HEADER, for: indexPath) as! MenuHeaderTableViewCell
            cell.addData(name: currentUser?.info.firstName ?? "", mobile: currentUser?.info.mobile ?? "", img: currentUser?.info.imgProfile ?? "")
            cell.selectionStyle = .none
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: UITABLEVIEWCELL_IDENTIFIRE.MENU, for: indexPath) as! MenuTableViewCell
        cell.selectionStyle = .none
        cell.menuImageView.image = UIImage(named: MENU.menuIconArray[indexPath.row])
        cell.menuNameLabel.text = MENU.menuTitleArray[indexPath.row]
        cell.menuDescriptionLAbel.text = MENU.menuDescriptionArray[indexPath.row]
        return cell
    }
}

extension ZFUMenuVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return UITableView.automaticDimension
    }
    //    [self.mm_drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate

        if  indexPath.row == selectedindex {
            // Do nothing
        }else{
            selectedindex = indexPath.row
            let ordersVC = self.storyboard?.instantiateViewController(withIdentifier: UIVIEWCONTROLLER_IDENTIFIRE.HOME) as! ZFUHomeVC
            var centerNavigationController = UINavigationController(rootViewController: ordersVC)
            if indexPath.row == 0 {
                selectedindex = indexPath.row
                let profileVC = self.storyboard?.instantiateViewController(withIdentifier: UIVIEWCONTROLLER_IDENTIFIRE.PROFILE) as! ZUCProfileViewController
         centerNavigationController = UINavigationController(rootViewController: profileVC)
            }
            if indexPath.row == 2 {
                let favoritesVC = self.storyboard?.instantiateViewController(withIdentifier: UIVIEWCONTROLLER_IDENTIFIRE.ORDERS) as! ZFUOrdersVC
                favoritesVC.fromMenu = true
                centerNavigationController = UINavigationController(rootViewController: favoritesVC)
            }else if indexPath.row == 3 {
                let profileVC = self.storyboard?.instantiateViewController(withIdentifier: UIVIEWCONTROLLER_IDENTIFIRE.accountViewController) as! accountViewController
                centerNavigationController = UINavigationController(rootViewController: profileVC)
            }else if indexPath.row == 4 {
                let supportVC = self.storyboard?.instantiateViewController(withIdentifier: UIVIEWCONTROLLER_IDENTIFIRE.FAVORITE) as! ZFUFavoritesVC
                centerNavigationController = UINavigationController(rootViewController: supportVC)
            }else if indexPath.row == 5 {
                //reviewZFUReviewVC
                let reviewVC = self.storyboard?.instantiateViewController(withIdentifier: UIVIEWCONTROLLER_IDENTIFIRE.reviewVC) as! ZFUReviewVC
                reviewVC.fromMenu = true
                centerNavigationController = UINavigationController(rootViewController: reviewVC)
                
            }else if indexPath.row == 6 {
                self.LogoutUser {
                UserDefaults.standard.removeObject(forKey: Constants.userDefaults.userDetail)
                     UserDefaults.standard.removeObject(forKey: Constants.userDefaults.usrToken)
                    
                                              let login = self.storyboard?.instantiateViewController(withIdentifier: "SelectTypeViewController") as! SelectTypeViewController
                                              login.modalPresentationStyle = .fullScreen
                                              self.present(login, animated: true, completion: nil)
                                              return
                }
                return
//                let contactUs = self.storyboard?.instantiateViewController(withIdentifier: UIVIEWCONTROLLER_IDENTIFIRE.ContactUs) as! ZFUContactus
//                centerNavigationController = UINavigationController(rootViewController: contactUs)
            }else if  indexPath.row == 7 {
              
            }else if indexPath.row == 8{
               
            }
            centerNavigationController.setNavigationBarHidden(true, animated: true)
            appDelegate.drawerController.centerViewController = centerNavigationController
        }
        appDelegate.drawerController.toggle(MMDrawerSide.left, animated: true, completion: nil)
    }
}
