//
//  ZFUChefDetailsVC.swift
//  Zfood-User
//
//  Created by apple on 06/05/19.
//  Copyright © 2019 WemakeAppz. All rights reserved.
//

import UIKit
import Cosmos

class ZFUChefDetailsVC: CommonViewController, CustomSliderDelegate {
    
    @IBOutlet weak var ebTxt: UITextView!
    
    @IBOutlet weak var instaTxt: UITextView!
    @IBOutlet weak var lblHandler: UILabel!
    @IBOutlet weak var sliderView: CustomSliderView!
    @IBOutlet weak var detailsTableView: UITableView!
    @IBOutlet weak var deliveryView: UIView!
    @IBOutlet weak var viewFav: UIView!
    @IBOutlet weak var lblItemCount: UILabel!
    @IBOutlet weak var heightWeek: NSLayoutConstraint!
    @IBOutlet weak var pickupView: UIView!
    @IBOutlet weak var viewFree: UIView!
    @IBOutlet weak var lblInstaUrl: UILabel!
    
    @IBOutlet weak var fbTxt: UITextView!
    @IBOutlet weak var imgHandler: UIImageView!
    @IBOutlet weak var lblChefRating: UILabel!
    @IBOutlet weak var lblChefName: UILabel!
    @IBOutlet weak var ImgChef: UIImageView!
    @IBOutlet weak var lblPreorder: UILabel!
    @IBOutlet weak var lblMaxOrder: UILabel!
    var timer = Timer()

    @IBOutlet weak var lblPreparationTime: UILabel!
    
    @IBOutlet weak var lblAddresss: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblArea: UILabel!
    @IBOutlet weak var imgFav: UIImageView!
    @IBOutlet weak var lblSun: UILabel!
       @IBOutlet weak var lblSat: UILabel!
       @IBOutlet weak var lblFri: UILabel!
       @IBOutlet weak var lblThu: UILabel!
       @IBOutlet weak var lblWed: UILabel!
       @IBOutlet weak var lblTuesday: UILabel!
       @IBOutlet weak var lblMonday: UILabel!
    @IBOutlet weak var viewRating: CosmosView!
    @IBOutlet weak var lblMiles: UILabel!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var lblWebsite: UILabel!
    @IBOutlet weak var lblfacebookLink: UILabel!
var chefId = ""
    @IBOutlet weak var viewInfo: UIView!
    var sliderType = 0
    var currentlyexpandedSection = 1000
    @IBOutlet weak var favBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
                    self.heightWeek.constant = 0

        if isguest{
            self.viewFav.isHidden = true
        }else{
            self.viewFav.isHidden = false

        }
        self.viewInfo.isHidden = true
        self.setupStatusBarColor(isEnable: true)
        self.setupSlider()
        timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(getCartCount), userInfo: nil, repeats: true)
        self.detailsTableView.register(UINib(nibName: UITABLEVIEWCELL_IDENTIFIRE.CUISINE_HEADER, bundle: nil), forCellReuseIdentifier: UITABLEVIEWCELL_IDENTIFIRE.CUISINE_HEADER)
        self.detailsTableView.register(UINib(nibName: UITABLEVIEWCELL_IDENTIFIRE.CUISINE, bundle: nil), forCellReuseIdentifier: UITABLEVIEWCELL_IDENTIFIRE.CUISINE)
        self.detailsTableView.register(UINib(nibName: UITABLEVIEWCELL_IDENTIFIRE.REVIEW, bundle: nil), forCellReuseIdentifier: UITABLEVIEWCELL_IDENTIFIRE.REVIEW)
       
        detailsTableView.estimatedRowHeight = UITableView.automaticDimension
        detailsTableView.rowHeight = 100
        
        
         NotificationCenter.default.addObserver(self, selector: #selector(self.ScreenUpdateNotification(notification:)), name: NSNotification.Name(rawValue: changeScreenNotification), object: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
        self.getChefList()
        
       // NotificationCenter
    }
    @objc func getCartCount(){
        self.isCart { (data) in
                  if data != nil{
                      let count = String(data?.data.count ?? 0)
                      self.lblItemCount.text = count
                  }else{
                      self.lblItemCount.text = "0"
                  }
              }
    }
    @objc func ScreenUpdateNotification(notification: NSNotification) {
        let userinfo = notification.userInfo
        
        if (userinfo?["data"] as? Dishdetail) != nil{
            self.gotoItemDetail(item: userinfo?["data"] as! Dishdetail)
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.setupStatusBarColor(isEnable: true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
        self.setupStatusBarColor(isEnable: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    //MARK:- Functions
    func getChefList(){
        getChefDetail(cehfID: self.chefId, loader: true) { (result, error) in
                   if error{
                       return
                   }else{
                       self.chefInfo()
                       self.detailsTableView.reloadData()
                   }
               }
             
    }
    func getAvailability(detail:ChefInfoModel){
        if detail.availablity == nil{
            return
        }
        if let daysArr = (detail.availablity).components(separatedBy: ",") as? [String]{
            if daysArr.count != 0{
                if daysArr.contains("1"){
                    self.lblMonday.textColor = #colorLiteral(red: 0.2783386707, green: 0.5934699178, blue: 0.04843180627, alpha: 1)
                }else{
                      self.lblMonday.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
                }
                if daysArr.contains("2"){
                                   self.lblTuesday.textColor = #colorLiteral(red: 0.2783386707, green: 0.5934699178, blue: 0.04843180627, alpha: 1)
                               }else{
                                     self.lblTuesday.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
                               }
                if daysArr.contains("3"){
                                   self.lblWed.textColor = #colorLiteral(red: 0.2783386707, green: 0.5934699178, blue: 0.04843180627, alpha: 1)
                               }else{
                                     self.lblWed.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
                               }
                if daysArr.contains("4"){
                                   self.lblThu.textColor = #colorLiteral(red: 0.2783386707, green: 0.5934699178, blue: 0.04843180627, alpha: 1)
                               }else{
                                     self.lblThu.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
                               }
                if daysArr.contains("5"){
                                   self.lblFri.textColor = #colorLiteral(red: 0.2783386707, green: 0.5934699178, blue: 0.04843180627, alpha: 1)
                               }else{
                                     self.lblFri.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
                               }
                if daysArr.contains("6"){
                                   self.lblSat.textColor = #colorLiteral(red: 0.2783386707, green: 0.5934699178, blue: 0.04843180627, alpha: 1)
                               }else{
                                     self.lblSat.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
                               }
                if daysArr.contains("7"){
                                   self.lblSun.textColor = #colorLiteral(red: 0.2783386707, green: 0.5934699178, blue: 0.04843180627, alpha: 1)
                               }else{
                                     self.lblSun.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
                               }
            }
        }
    }

    func setupSlider() {
        self.sliderView.delegate = self
        self.sliderView.titleArray = ["Dish Type", "Review", "Info"]
        self.sliderView.selectedTitleColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        self.sliderView.deselectedTitleColor = UIColor.darkGray
        self.sliderView.selectedBarColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        self.sliderView.deselectedBarColor = UIColor.clear
    }
    
    func FavUnFavChef(status:String,chefId:String){
         let param = ["status":status,"chef_id":self.chefId,"user_id":currentUser?.info.inUserId ?? ""] as [String : Any]
         APIServices().Fav_API(params: param, viewController: self, loader: false) { (data, error) in
            self.getChefList()
         }
     }
    
     func chefInfo(){
            let data = chefDetail?.info
        self.getAvailability(detail: data!)
        chefIDFORItemDEtail = chefDetail?.info.inChefId ?? ""
            self.lblChefName.text = data?.chefName
            self.lblArea.text = data?.smallAddress
        self.lblAddresss.text = data?.smallAddress
            self.imgFav.image = chefDetail?.info.fav == "1" ? #imageLiteral(resourceName: "ic_favorite_accent"):#imageLiteral(resourceName: "Path_pink")
            self.ImgChef.getImage(url: data?.profileImg ?? "")
        self.fbTxt.text = data?.facebook_url.lowercased() ?? "www.google.com"
        self.instaTxt.text = data?.instaLink.lowercased() ?? "www.google.com"
        self.ebTxt.text = data?.website_url.lowercased() ?? "www.google.com"
        self.lblChefRating.text = "(\(chefDetail?.reviews.count ?? 0))"
        self.viewRating.rating = Double((data?.rating)!)!
           // self.lblfacebookLink.attributedText = linkClickAble(str: "www.google.com")
        if data?.freeDish == "1"{
            self.viewFree.isHidden = false
        }else{
            self.viewFree.isHidden = true
        }
        if data?.handler == "" || data?.handler == nil{
                   self.lblHandler.isHidden = true
                   self.imgHandler.isHidden = true

               }else{
                   self.lblHandler.isHidden = false
                              self.imgHandler.isHidden = false
               }
        
    
        if data?.order_type == "1"{
        self.deliveryView.isHidden = false
                   self.pickupView.isHidden = true
    }else if data?.order_type  == "2"{
        self.deliveryView.isHidden = true
                   self.pickupView.isHidden = false
    }else{
        self.deliveryView.isHidden = false
        self.pickupView.isHidden = false

    }
    }
    func linkClickAble(str:String) -> NSAttributedString?{
           let attributedString = NSMutableAttributedString(string:str)
           let linkWasSet = attributedString.setAsLink(textToFind: str, linkURL: str)
           
           if linkWasSet {
               return attributedString
               // adjust more attributedString properties
           }
           return nil
       }
    //MARK:- CustomSliderDelegate
    func didTapOnTitle(index: Int) {
        self.sliderType = index
        print(index)
        if index == 2 {
            self.viewInfo.isHidden = false
            self.detailsTableView.isHidden = true
        }else {
            self.detailsTableView.isHidden = false
             self.viewInfo.isHidden = true
        }
        self.detailsTableView.reloadData()
    }
    
   

//MARK:- Button Action

    
    @IBAction func btnfaceLink(_ sender: Any) {
        let data = chefDetail?.info

        if let url = URL(string: data?.facebook_url ?? "") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }else{
            self.view.makeToast("invalid url")
        }
    }
    
    @IBAction func openInstaLink(_ sender: Any) {
        let data = chefDetail?.info

        if let url = URL(string: data?.instaLink ?? "") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }else{
            
    }
    }
    
    @IBAction func btnWebsiteLink(_ sender: Any) {
        let data = chefDetail?.info

        if let url = URL(string: data?.website_url ?? "") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }else{
            self.view.makeToast("invalid url")
        }
    }
    @IBAction func handleGotoCart(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: UIVIEWCONTROLLER_IDENTIFIRE.CART) as! ZFUCartVC
              let aObjNavi = UINavigationController(rootViewController: vc)
        vc.navigationController?.navigationBar.isHidden = true
        aObjNavi.modalPresentationStyle = .fullScreen
              self.present(aObjNavi, animated: true) {
              }
    }
    
    @IBAction func backButtonDidTap(_ sender: UIButton) {
           self.dismiss(animated: true, completion: nil)
       }
    
    @IBAction func handleFav(_ sender: Any) {
          if imgFav.image == #imageLiteral(resourceName: "ic_favorite_accent"){
              imgFav.image = #imageLiteral(resourceName: "Path_pink")
               self.FavUnFavChef(status: "0", chefId: self.chefId)
          }else{
               imgFav.image = #imageLiteral(resourceName: "ic_favorite_accent")
               self.FavUnFavChef(status: "1", chefId: self.chefId)
          }
      }
    
    @objc func expandSectionOnTap(sender:UIButton) {
           if sender.tag != currentlyexpandedSection {
               currentlyexpandedSection = sender.tag
                self.detailsTableView.reloadData()
               let indexP = IndexPath(row: 0, section: sender.tag)
                  if indexP != nil{
                  self.detailsTableView.scrollToRow(at:indexP , at: .top, animated: true)
                  }
           }else{
               currentlyexpandedSection = 1000
               self.detailsTableView.reloadData()
           }
           self.detailsTableView.beginUpdates()
          self.detailsTableView.endUpdates()
       }
    
    @IBAction func handleAvaibility(_ sender: Any) {
//           if         self.heightWeek.constant == 40{
//               self.heightWeek.constant = 0
//           }else{
//               self.heightWeek.constant = 40
//           }
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "WorkingDaysViewController") as! WorkingDaysViewController
        vc.avaibility = chefDetail?.info.availablity ?? ""
        let navi = UINavigationController(rootViewController: vc)
        navi.modalPresentationStyle = .overCurrentContext
        navi.navigationBar.isHidden = true
        self.present(navi, animated: false, completion: nil)
       }
    func gotoItemDetail(item:Dishdetail){
        let itemDetailsVC = self.storyboard?.instantiateViewController(withIdentifier: UIVIEWCONTROLLER_IDENTIFIRE.ITEM_DETAILS) as! ZFUItemDetailsVC
        
                    itemDetailsVC.detail = item
        itemDetailsVC.available = self.chefDetail?.info.todayAvailable ?? false
                   itemDetailsVC.rest_id = self.chefDetail?.info.inChefId ?? ""
        itemDetailsVC.chefName = self.chefDetail?.info.chefName ?? ""
                   itemDetailsVC.modalPresentationStyle = .fullScreen
                   self.present(itemDetailsVC, animated: true, completion: nil)
        
    }

}
extension ZFUChefDetailsVC: UITableViewDataSource,UITableViewDelegate {
    //MARK:- Tableview Datasource & Delegates
    func numberOfSections(in tableView: UITableView) -> Int {
        if self.sliderType == 0 {
            return chefDetail?.cuisines.count ?? 0
        }
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.sliderType == 0 {
            if currentlyexpandedSection == section{
                return 1
            }else{
                return 0
            }
        }else if self.sliderType == 1 {
            return self.chefDetail?.reviews.count ?? 0
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if self.sliderType == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: UITABLEVIEWCELL_IDENTIFIRE.CUISINE, for: indexPath) as! CuisineTableViewCell
            cell.getItemsInCuisine(items: self.chefDetail?.cuisines[indexPath.section].dishdetails)
            cell.layoutSubviews()
            self.view.layoutSubviews()
            cell.selectionStyle = .none
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: UITABLEVIEWCELL_IDENTIFIRE.REVIEW, for: indexPath) as! ReviewTableViewCell
            cell.getData(detail: (self.chefDetail?.reviews[indexPath.row]) ?? nil)
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableCell(withIdentifier: UITABLEVIEWCELL_IDENTIFIRE.CUISINE_HEADER) as! CuisineHeaderTableViewCell
        if self.sliderType == 0 {
            header.isHidden = false
            let data = chefDetail?.cuisines[section]
            header.titleLabel.text = data?.cuisineName
        }else {
            header.isHidden = true
        }
        header.expButton.tag = section
        header.expButton.addTarget(self, action: #selector(self.expandSectionOnTap(sender:)), for: .touchUpInside)
        if currentlyexpandedSection == section{
            header.dropdownImageView.image = UIImage(named: "Path 1036")
        }else{
            header.dropdownImageView.image = UIImage(named: "Path 1036")
        }
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if self.sliderType == 0 {
            return 55
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.sliderType == 0 {
            return self.view.frame.height/2.2
        }
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
         if self.sliderType == 0 {
       
        }
       
    }
}
extension NSMutableAttributedString {
    
    public func setAsLink(textToFind:String, linkURL:String) -> Bool {
        
        let foundRange = self.mutableString.range(of: textToFind)
        if foundRange.location != NSNotFound {
            self.addAttribute(.link, value: linkURL, range: foundRange)
            return true
        }
        return false
    }
}
