//
//  ZFUItemDetailsVC.swift
//  Zfood-User
//
//  Created by apple on 10/05/19.
//  Copyright © 2019 WemakeAppz. All rights reserved.
//

import UIKit
var chefIDFORItemDEtail = String()
class ZFUItemDetailsVC: CommonViewController {
    var detail : Dishdetail?
    var placeholderDis = "Add a note (Food allergies, no onion, etc) Please be clear and consice so we can get your order perfect."
    var chefID : String?
    var chefName : String?
    let strAddToCart = "Add To Cart"
    @IBOutlet weak var btnAddToCart: LoadingButton!
    @IBOutlet weak var heightCart: NSLayoutConstraint!
    @IBOutlet weak var lblMinOrder: UILabel!
    @IBOutlet weak var lblHours: UILabel!
    @IBOutlet weak var detailLine: UIView!
    @IBOutlet weak var btnitemsCount: UIButton!
    //@IBOutlet weak var reviewLine: UIView!
    //@IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var pageControll: UIPageControl!
    @IBOutlet weak var dishNameLabel: UILabel!
    @IBOutlet weak var dishPriceLabel: UILabel!
    @IBOutlet weak var lblCount: UILabel!
    @IBOutlet weak var dishDescriptionLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var lblMaxOrder: UILabel!
    @IBOutlet weak var heightCartView: UIView!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var commentTextField: UITextView!
    var available = Bool()
    var count = 1
    var rest_id = ""
    override func viewDidLoad() {
        super.viewDidLoad()
         showDetailine()
        commentTextField.text = placeholderDis
        commentTextField.textColor = UIColor.lightGray
itemDetail()
         self.setupStatusBarColor(isEnable: false)
        self.collectionView.register(UINib(nibName: "cell_collectionItemImages", bundle: nil), forCellWithReuseIdentifier: "cell_collectionItemImages")
        btnCartUpdate()
    }
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getCartCount()
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        navigationController?.setNavigationBarHidden(true, animated: animated)

    }
    //MARK:- Button Action
    @IBAction func backButtonDidTap(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
   
    @IBAction func handleCart(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: UIVIEWCONTROLLER_IDENTIFIRE.CART) as! ZFUCartVC
              let aObjNavi = UINavigationController(rootViewController: vc)
        aObjNavi.modalPresentationStyle = .fullScreen
        vc.navigationController?.navigationBar.isHidden = true

              self.present(aObjNavi, animated: true) {
              }
    }
    @IBAction func incButtonDidTap(_ sender: UIButton) {
        count += 1
      btnCartUpdate()
    }
    @IBAction func handleopenDetail(_ sender: Any) {
        self.showDetailine()
    }
    
    @IBAction func handleOpenReview(_ sender: Any) {
        self.showReviewLine()
    }
   
    @IBAction func decButtonDidTap(_ sender: UIButton) {
        if count == 1{
            return
        }
        count = count - 1
        btnCartUpdate()
    }
    
    @IBAction func addToOrderButtonDidTap(_ sender: UIButton) {
//        if GlofromSearchList{
//            if available{
//                 AddToCart()
//                return
//            }
//        }else{
            AddToCart()
       //  }
      
    }
    //MARK:- Functions
    func addNav(){
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: 320, height: 44))
        view.addSubview(navBar)

        let navItem = UINavigationItem(title: "SomeTitle")
        let doneItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: nil, action: #selector(done))
        navItem.rightBarButtonItem = doneItem
        let CartItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: nil, action: #selector(done))
               navItem.rightBarButtonItem = doneItem

        navBar.setItems([navItem], animated: false)
    }
    @objc func done(){
        
    }
    @objc func Cartgoto(){
       }
    
    func getCartCount(){
        self.isCart { (data) in
            if data != nil{
                let count = String(data?.data.count ?? 0)
                if let id = data?.data[0].in_chef_Id{
                               self.chefID = id
                           }
                if data?.data.count != 0{
                    self.heightCart.constant = 50
                    
                    self.btnitemsCount.setTitle("\(data?.data.count ?? 0) \(data?.data.count == 1 ? "item":"items") / $\(data?.cart_total ?? "")", for: .normal)
                }else{
                    self.heightCart.constant = 0
                }
                self.lblCount.text = count
            }else{
                  self.heightCart.constant = 0
                 self.lblCount.text = "0"
            }
        }
        self.view.layoutIfNeeded()
    }
    func showDetailine(){
           self.detailLabel.textColor = #colorLiteral(red: 0.2783386707, green: 0.5934699178, blue: 0.04843180627, alpha: 1)
           self.detailLine.isHidden = false
         //  self.reviewLine.isHidden = true
          // self.reviewLabel.textColor = #colorLiteral(red: 0.370555222, green: 0.3705646992, blue: 0.3705595732, alpha: 1)
       }
       func showReviewLine(){
          // self.reviewLabel.textColor = #colorLiteral(red: 0.2783386707, green: 0.5934699178, blue: 0.04843180627, alpha: 1)
                  self.detailLine.isHidden = true
                 // self.reviewLine.isHidden = false
                  self.detailLabel.textColor = #colorLiteral(red: 0.370555222, green: 0.3705646992, blue: 0.3705595732, alpha: 1)
       }
      
    func itemDetail(){
           self.dishNameLabel.text = detail?.stDishName
           self.dishPriceLabel.text = "\(Constants.Currency.doller)\(detail?.stPrice ?? "0")"
        self.dishDescriptionLabel.text = "Serving size: \(detail?.servingSize ?? "")"
          // self.dishImageView.sd_setIndicatorStyle(.gray)
        self.lblDescription.text = detail?.dishDesription
        self.lblHours.text = "\(detail?.cooking_time ?? "")"
        self.lblMinOrder.text = detail?.min_order
        self.lblMaxOrder.text = detail?.maxOrder
       }
    func btnCartUpdate(){
           self.btnAddToCart.setTitle("\(strAddToCart) (\(String(count)))", for: .normal)
       }
    func AddToCart(){
        if isguest{
            Alert().showActionSheet(title: "Please login first", okTitle: "Login", cancelTitle: "Cancel", message: "", viewController: self, okAction: {
                let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                                                                  let initialViewControlleripad = mainStoryboardIpad.instantiateViewController(withIdentifier: "ZFULoginVC") as! ZFULoginVC
                                                                      let nav = UINavigationController(rootViewController: initialViewControlleripad)
                                                          nav.navigationBar.isHidden = true
                                                          nav.modalPresentationStyle = .fullScreen
                initialViewControlleripad.fromGuestUser = true
                                                          UserDefaults.standard.removeObject(forKey: Constants.userDefaults.userDetail)
                                                        currentUser = nil
                                                                              UserDefaults.standard.removeObject(forKey: Constants.userDefaults.usrToken)
                self.present(nav, animated: false, completion: nil)
            }) {
                
            }
            return
        }
        if self.chefID == "" || self.chefID == self.rest_id || self.chefID == nil{
            btnAddToCart.showLoading()
        let param = ["user_id":currentUser?.info.inUserId ?? "","dish_id":self.detail?.inDishId ?? "","chef_id":chefIDFORItemDEtail,"qty":self.count,
                     "instruction":self.commentTextField.text != placeholderDis ?(self.commentTextField.text ?? "") :""
            ] as [String : Any]
        APIServices().Add_CART_API(params: param, viewController: self, loader: false) { (data, error) in
           self.btnAddToCart.hideLoading()
            if error == "error"{
                self.view.makeToast("Can't add item at this time", duration: 3.0, position: .bottom)
                return
            }
            self.getCartCount()
            let msg : String = data?.msg ?? ""
            if msg != ""{
                self.showErrorGreen(msg: data?.msg ?? "")
            }
        }
        }else{
            Alert().OKAlertControllerCustom(Message: "Remove items of previous chef ", okText: "OK", alertMsg: "Alert!") {
                let param = ["user_id":currentUser?.info.inUserId ?? ""] as [String : Any]
                APIServices().DELETE_CART_API(params: param, viewController: self, loader: true) { (data, error) in
                    if error == "error"{
                        self.view.makeToast("Can't remove cart at this time", duration: 3.0, position: .bottom)
                        return
                    }
                    self.chefID = ""
                     self.AddToCart()
                }
            }
        }
    
    }}
extension ZFUItemDetailsVC:UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = placeholderDis
            textView.textColor = UIColor.lightGray
        }
    }
}
extension ZFUItemDetailsVC : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pageControll.numberOfPages = self.detail?.dishImage.count ?? 0
        return self.detail?.dishImage.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "cell_collectionItemImages", for: indexPath) as! cell_collectionItemImages
        cell.addData(data: self.detail?.dishImage[indexPath.row].imageURL ?? "")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
       // return CGSize(width: 100, height: 500)
    }
   func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

        pageControll?.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }

    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {

        pageControll?.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
}
