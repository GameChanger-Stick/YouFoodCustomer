//
//  ZFUHomeVC.swift
//  Zfood-User
//  Created by apple on 06/05/19.
//  Copyright © 2019 WemakeAppz. All rights reserved.

import UIKit
import GooglePlaces
import RangeSeekSlider
import SlideMenuControllerSwift
protocol DelegateDimVIEW{
    func hideDimView()
}
extension ZFUHomeVC{
    //MARK:- Initial Setup
    func setupView(){
         rangeSlider.isHidden = true
        timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(getCartCount), userInfo: nil, repeats: true)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
         appDelegate.drawerController.openDrawerGestureModeMask = .panningNavigationBar
         rangeSlider.delegate = self
        self.dimView.isHidden = true
        self.lblNotificationCount.isHidden = badgeCount == 0 ? true:false
         self.lblNotificationCount.isHidden = true
         addressLineTwoLabel.text = Selectedaddress
         // Do any additional setup after loading the view.
         self.chefListTableView.register(UINib(nibName: UITABLEVIEWCELL_IDENTIFIRE.HOME_HEADER, bundle: nil), forCellReuseIdentifier: UITABLEVIEWCELL_IDENTIFIRE.HOME_HEADER)
         self.chefListTableView.register(UINib(nibName: UITABLEVIEWCELL_IDENTIFIRE.CHEF_LIST_HEADER, bundle: nil), forCellReuseIdentifier: UITABLEVIEWCELL_IDENTIFIRE.CHEF_LIST_HEADER)
         self.chefListTableView.register(UINib(nibName: UITABLEVIEWCELL_IDENTIFIRE.CHEF_LIST, bundle: nil), forCellReuseIdentifier: UITABLEVIEWCELL_IDENTIFIRE.CHEF_LIST)
         self.chefListTableView.register(UINib(nibName: UITABLEVIEWCELL_IDENTIFIRE.HOME_DISTANCE, bundle: nil), forCellReuseIdentifier: UITABLEVIEWCELL_IDENTIFIRE.HOME_DISTANCE)
         self.topCollectionView.register(UINib(nibName: UICOLLECTIONVIEWCELL_IDENTIFIRE.HOME_HEADER, bundle: nil), forCellWithReuseIdentifier: UICOLLECTIONVIEWCELL_IDENTIFIRE.HOME_HEADER)
         //cell_DistanceFilter
         
         rangeSlider.numberFormatter.positiveSuffix = " Miles"
         notificationForfav()
        NotificationCenter.default.addObserver(self, selector: #selector(notificationbadge), name: .badgeNoti, object: nil)
       // self.CallNotificationAPI()
        self.addressLineTwoLabel.text = GloAddress1
         pulToRefresh()
         maxPrice = ""
         minDis = "0"
         maxDis = "100"
        self.getChefList(loader: true, cuisineId: "", name: "")
    }
    
}
class ZFUHomeVC: CommonViewController {
    //OUTLETS
    
    @IBOutlet weak var scroll: UIScrollView!
    @IBOutlet weak var addressLineTwoLabel: UILabel!
    @IBOutlet weak var chefListTableView: UITableView!
    @IBOutlet var lblCartCount: UILabel!
    @IBOutlet weak var rangeSlider: RangeSeekSlider!
    @IBOutlet weak var topCollectionView: UICollectionView!
    @IBOutlet weak var lblNotificationCount: UILabel!
    @IBOutlet weak var btnNotification: UIButton!
    @IBOutlet weak var dimView: UIView!
    var forNotification = false
    var cousinID = ""
    var timer = Timer()
    //VARIABLES
    var refreshControl = UIRefreshControl()
    var drawerController:MMDrawerController!
    var chefList : ModelChefList?
    ///
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
           NotificationCenter.default.addObserver(self, selector: #selector(reloadORderList), name: NSNotification.Name(rawValue: NotificationCenter.openchefList), object: nil)
        
    }
    @objc func reloadORderList(notification: NSNotification){
        if let id = notification.userInfo?["id"] as? Int{
            if chefList?.chefInfo.count == 0{
                return
            }
            if let chef = chefList?.chefInfo[id]{
                if let idd = chef.inChefId{
                    self.gotoChefDetail(id:idd )

                }
            }
            return
            
            let VC = self.storyboard?.instantiateViewController(withIdentifier: UIVIEWCONTROLLER_IDENTIFIRE.CheckYourAvailabiltyVC)
                             as! CheckYourAvailabiltyVC
                 VC.chefID = chefList?.chefInfo[id].inChefId ?? ""
                  VC.openDays = chefList?.chefInfo[id].availablity ?? ""
                  VC.delegate = self
                  VC.modalPresentationStyle = .overFullScreen
                  self.present(VC, animated: false, completion: nil)
        }}
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden = true
       // self.getChefList(loader: false, cuisineId: "", name: "")
        self.isCart { (data) in
            if data != nil{
                let count = String(data?.data.count ?? 0)
                self.lblCartCount.text = count
            }else{
                self.lblCartCount.text = "0"
            }
        }
         notificationForfav()
        if forNotification{
            gotoNotification()
        }
       
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.removeObserverNoti()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // self.heightTableView.constant = self.chefListTableView.contentSize.height + 200
    }
    //MARK:- Button Actions
    
    @IBAction func handleNotification(_ sender: Any) {
        gotoNotification()
    }
    @IBAction func handleChangeSlider(_ sender: RangeSeekSlider) {
        //sender.min
    }
    @objc func notificationReceived(_ notification: Notification) {
        guard let id = notification.userInfo?["index"] as? Int else { return }
        guard let status = notification.userInfo?["status"] as? String else { return }
        self.FavUnFavChef(status: status, chefId: chefList?.chefInfo[id].inChefId ?? "")
    }
    
    @objc func refresh(sender:AnyObject) {
        getChefList(loader: true, cuisineId: self.cousinID, name: "")
        refreshControl.endRefreshing()
    }
    @objc func expandAvaibility(sender:UIButton) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "WorkingDaysViewController") as! WorkingDaysViewController
        vc.modalPresentationStyle = .overCurrentContext
        vc.avaibility = chefList?.chefInfo[sender.tag].availablity ?? ""
        self.navigationController?.present(vc, animated: false, completion: nil)
//        if (chefList?.chefInfo[sender.tag].isexpand)!{
//            chefList?.chefInfo[sender.tag].isexpand = false
//        }else{
//            chefList?.chefInfo[sender.tag].isexpand = true
//        }
//        self.chefListTableView.reloadData()
    }
    
    @IBAction func menuButtonDidTap(_ sender: UIButton) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        appDelegate.drawerController.open(.left, animated: true) { (result) in
            
        }
    }
    
    @IBAction func changeDifferentLocationButtonDidTap(_ sender: UIButton) {
        openGooglePlace()
    }
    
    @IBAction func cartButtonDidTap(_ sender: UIButton) {
       
        let vc = storyboard?.instantiateViewController(withIdentifier: UIVIEWCONTROLLER_IDENTIFIRE.CART) as! ZFUCartVC
        let aObjNavi = UINavigationController(rootViewController: vc)
        aObjNavi.modalPresentationStyle = .fullScreen
        vc.navigationController?.navigationBar.isHidden = true
        self.present(aObjNavi, animated: true) {
        }
    }
    
    @IBAction func filterButtonDidTap(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SearchDishListViewController") as! SearchDishListViewController
              let aObjNavi = UINavigationController(rootViewController: vc)
              aObjNavi.modalPresentationStyle = .fullScreen
              vc.navigationController?.navigationBar.isHidden = true
              self.present(aObjNavi, animated: true) {
              }
    }
    
    //MARK:- Function
    @objc func getCartCount(){
        self.isCart { (data) in
                  if data != nil{
                      let count = String(data?.data.count ?? 0)
                      self.lblCartCount.text = count
                  }else{
                      self.lblCartCount.text = "0"
                  }
              }
    }
    func notificationForfav(){
        NotificationCenter.default.addObserver(self, selector: #selector(self.notificationReceived(_:)), name: .favChef, object: nil)
    }
   @objc func notificationbadge(){
       self.lblNotificationCount.isHidden = badgeCount == 0 ? true:false

    }
    func removeObserverNoti(){
        NotificationCenter.default.removeObserver(self, name: .favChef, object: nil)
    }
    func pulToRefresh(){
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(sender:)), for: UIControl.Event.valueChanged)
        chefListTableView.addSubview(refreshControl)
    }
    func openGooglePlace(){
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        // Specify the place data types to return.
        let fields: GMSPlaceField = GMSPlaceField(rawValue: UInt(GMSPlaceField.name.rawValue) |
            UInt(GMSPlaceField.placeID.rawValue) | UInt(GMSPlaceField.coordinate.rawValue) | UInt(GMSPlaceField.addressComponents.rawValue) | UInt(GMSPlaceField.formattedAddress.rawValue))!
        autocompleteController.placeFields = fields
        // Specify a filter.
        let filter = GMSAutocompleteFilter()
       // filter.type = .address
       // filter.country = "USA"
        let searchBound = getCoordinateBounds(latitude: CLLocationDegrees(userLAT), longitude: CLLocationDegrees(userLNG), distance: 3.45)
            autocompleteController.autocompleteBounds = searchBound
        autocompleteController.autocompleteFilter = filter
        present(autocompleteController, animated: true, completion: nil)
    }
    func getCoordinateBounds(latitude:CLLocationDegrees ,
                                longitude:CLLocationDegrees,
                                distance:Double = 0.001)->GMSCoordinateBounds{
           let center = CLLocationCoordinate2D(latitude: latitude,
                                               longitude: longitude)
           let northEast = CLLocationCoordinate2D(latitude: center.latitude + distance, longitude: center.longitude + distance)
           let southWest = CLLocationCoordinate2D(latitude: center.latitude - distance, longitude: center.longitude - distance)

           return GMSCoordinateBounds(coordinate: northEast,
                                      coordinate: southWest)

       }
    func gotoNotification(){
        if isguest{
            self.view.makeToast("Please login")
            return
        }
         let vc = storyboard?.instantiateViewController(withIdentifier: "NotificationViewController") as! NotificationViewController
        vc.delegate = self
        vc.delegateChefDetail = self
        badgeCount = 0
        vc.modalPresentationStyle = .popover
        vc.preferredContentSize = CGSize(width: vc.view.frame.size.width, height: 400)
        vc.popoverPresentationController?.delegate = self
        vc.popoverPresentationController?.permittedArrowDirections = .any
        vc.popoverPresentationController?.sourceView = btnNotification
        vc.popoverPresentationController?.sourceRect = btnNotification.bounds
        self.dimView.isHidden = false
                   self.present(vc, animated: true) {
                    
                   }
     }
   
}
extension ZFUHomeVC {
    //MARK:-API Functions
    func gotoCuisinesVC(index:Int){
               let vcc = self.storyboard?.instantiateViewController(withIdentifier: "CuisinesViewController") as! CuisinesViewController
               vcc.cuisin = chefList?.cuisinedata[index]
               let nv = UINavigationController(rootViewController: vcc)
               self.present(nv, animated: true, completion: nil)
           }
    func FavUnFavChef(status:String,chefId:String){
           let param = ["status":status,"chef_id":chefId,"user_id":currentUser?.info.inUserId ?? ""] as [String : Any]
           APIServices().Fav_API(params: param, viewController: self, loader: false) { (data, error) in
            self.view.makeToast(data?.msg)
            self.getChefList(loader: false, cuisineId: self.cousinID, name: "")
           }
          
           
       }
    func CallNotificationAPI(){
        //http://3.94.1.254/mobile/notificationlist?user_id=1
        let param = ["user_id":currentUser?.info.inUserId ?? ""] as [String : Any]
        APIServices().GetNotification(params: param, viewController: self, loader: false) { (data, error) in
            if data != nil{
                self.lblNotificationCount.isHidden = false
            }else{
                self.lblNotificationCount.isHidden = true
            }
        }
    }

    func getcusineList(loader:Bool, cuisineId: String,name:String) {
           let param = ["name":name,"price_min":minPrice,"price_max":maxPrice,"dish_type":foodType,"user_id":currentUser?.info.inUserId ?? "", "cuisine_id": cuisineId,"lat":Double(userLAT),"lng":Double(userLNG),"minDistance":minDis,"maxDistance":maxDis] as [String : Any]
           APIServices().GET_CHEF_LIST(params: param, viewController: self, loader: loader) { (data, error) in
               if data == nil{
                   
                   self.chefList?.chefInfo.removeAll()
                   self.chefListTableView.reloadData()
                   return
               }
               self.chefList = data
               self.chefListTableView.reloadData()
               self.topCollectionView.reloadData()
               self.rangeSlider.isHidden = false
           }
       }
       func getChefList(loader:Bool, cuisineId: String,name:String) {
              let param = ["name":name,"price_min":minPrice,"price_max":maxPrice,"dish_type":foodType,"user_id":currentUser?.info.inUserId ?? "", "cuisine_id": cuisineId,"lat":Double(userLAT),"lng":Double(userLNG),"minDistance":minDis,"maxDistance":maxDis] as [String : Any]
              APIServices().GET_CHEF_LIST(params: param, viewController: self, loader: loader) { (data, error) in
                  if data == nil{
                      self.chefList?.chefInfo.removeAll()
                      self.chefListTableView.reloadData()
                      return
                  }
                  self.chefList = data
                  self.chefListTableView.reloadData()
                  self.topCollectionView.reloadData()
                  self.rangeSlider.isHidden = false
              }
          }
    
}
extension ZFUHomeVC: UITableViewDataSource,UITableViewDelegate {
    //MARK:- Tableview Datasource & Delegates
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return chefList?.chefInfo.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: UITABLEVIEWCELL_IDENTIFIRE.CHEF_LIST, for: indexPath) as! ChefListTableViewCell
        cell.favoriteButton.tag = indexPath.row
        cell.btn_avaibility.tag = indexPath.row
        cell.indexpathQ = indexPath.row
        cell.btn_avaibility.addTarget(self, action: #selector(
            self.expandAvaibility(sender:)), for: .touchUpInside)
        cell.getChef(detail: (chefList?.chefInfo[indexPath.row])!)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.gotoChefDetail(id: chefList?.chefInfo?[indexPath.row].inChefId ?? "")
       return
        let VC = self.storyboard?.instantiateViewController(withIdentifier: UIVIEWCONTROLLER_IDENTIFIRE.CheckYourAvailabiltyVC)
                   as! CheckYourAvailabiltyVC
       VC.chefID = chefList?.chefInfo[indexPath.row].inChefId ?? ""
        VC.openDays = chefList?.chefInfo[indexPath.row].availablity ?? ""
        VC.delegate = self
        VC.modalPresentationStyle = .overFullScreen
        self.present(VC, animated: false, completion: nil)
    }
    
}



extension ZFUHomeVC : GMSAutocompleteViewControllerDelegate {
    
    //MARK:- GMSAutocompleteViewControllerDelegate
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        print("Place name: \(place.name)")
               print("Place ID: \(place.placeID)")
               print("Place attributions: \(place.attributions)")
               userLAT = Double(place.coordinate.latitude)
               userLNG = Double(place.coordinate.longitude)
              GloLat = "\(userLAT)"
        GloLng = "\(userLNG)"
               for obj in place.addressComponents!{
                   if obj.types[0] == "route"{
                       SelectedLocality = obj.name
                   }
               }
               Selectedaddress = place.formattedAddress!
               GloAddress1 = Selectedaddress
               self.addressLineTwoLabel.text = Selectedaddress
        self.getChefList(loader: true, cuisineId: "", name: "")
               dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}
//MARK:- UITextFieldDelegate

extension ZFUHomeVC : UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        getChefList(loader: false, cuisineId: self.cousinID, name: "")
        return true
    }
}
//MARK:- FilterProtocol
extension ZFUHomeVC : FilterProtocol{
    func fiterValue() {
        if foodType != "" || maxPrice != "" || minPrice != ""{
            self.view.makeToast("Filter Applied")
            //self.btnFilter.setImage(#imageLiteral(resourceName: "ic_tune_orange"), for: .normal)
        }else{
            self.view.makeToast("Filter Removed")
            // self.btnFilter.setImage(#imageLiteral(resourceName: "ic_tune_gray"), for: .normal)
        }
        //searchTextField.text = ""
        getChefList(loader: true, cuisineId: self.cousinID, name: "")
    }
}

extension ZFUHomeVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    //MARK:- UICollectionView DataSource

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UICOLLECTIONVIEWCELL_IDENTIFIRE.HOME_HEADER, for: indexPath) as! HomeHeaderCollectionViewCell
        cell.addData(from: (self.chefList?.cuisinedata[indexPath.item])!, index: indexPath.item)
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cuisideId = self.chefList?.cuisinedata[indexPath.item].id{
            self.cousinID = cuisideId
            indexSelected = indexPath.item
            topCollectionView.reloadData()
            getChefList(loader: true, cuisineId: self.cousinID, name: "")
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.chefList?.cuisinedata.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.topCollectionView.frame.width / 4.8 - 12
        return CGSize(width: width, height: self.topCollectionView.frame.size.height)
    }
    
}
extension ZFUHomeVC: RangeSeekSliderDelegate {

    func rangeSeekSlider(_ slider: RangeSeekSlider, didChange minValue: CGFloat, maxValue: CGFloat) {
      }
    func didStartTouches(in slider: RangeSeekSlider) {
        print("did start touches")
    }

    func didEndTouches(in slider: RangeSeekSlider) {
        if slider === rangeSlider {
            maxDis = "\(slider.selectedMaxValue)"
            minDis = "\(slider.selectedMinValue)"
            getChefList(loader: true, cuisineId: self.cousinID, name: "")
              }
    }
}
extension ZFUHomeVC : GotoChefDetailDelegate{
    //MARK:- GotoChefDetail
    
    func gotoChefDetail(id: String) {
        self.dimView.isHidden = true
                let chefDetailsVC = self.storyboard?.instantiateViewController(withIdentifier: UIVIEWCONTROLLER_IDENTIFIRE.CHEF_DETAILS)as! ZFUChefDetailsVC
                chefDetailsVC.chefId = id
        GlofromSearchList = false
                      chefDetailsVC.modalPresentationStyle = .overFullScreen
                      self.present(chefDetailsVC, animated: true, completion: nil)
            }
    }
  //MARK:- POPUP delegates
extension ZFUHomeVC : UIPopoverPresentationControllerDelegate,DelegateDimVIEW{
    func hideDimView() {
        
    }
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        self.dimView.isHidden = true
        self.lblNotificationCount.isHidden = badgeCount == 0 ? true:false
        //self.CallNotificationAPI()
    }
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}

