//  ZFUCartVC.swift
//  Zfood-User

import UIKit
var timerCart = Timer()

class ZFUCartVC: CommonViewController {

    @IBOutlet weak var dimView: UIView!
    @IBOutlet weak var lblDeliveryCharge: DesignableLabel!
    @IBOutlet weak var cartTableView: UITableView!
    var cartList : Model_CART?
    @IBOutlet weak var stackViewCheck: UIStackView!
    @IBOutlet weak var viewDeliveryOption: UIView!
    @IBOutlet weak var heightDeliveryView: NSLayoutConstraint!
    @IBOutlet weak var heightDeliveryOptions: NSLayoutConstraint!
    @IBOutlet weak var noitemView: UIView!
    var datePicker : UIDatePicker!
    let dateFormatter = DateFormatter()
    var presenter : CartPresenter?
    let viewT = UIView()
    let toolBar = UIToolbar()
    var deliveryType: String?
    var orderID : String?
    var openDays : String?
    
    @IBOutlet weak var viewDeliveryTime: UIView!
    @IBOutlet weak var lblDeliveryTime: UITextField!
    @IBOutlet weak var LBLserviceFee: DesignableLabel!
   var fromOrderScreen = false
    @IBOutlet weak var lblSelectDeliveryType: UILabel!
    @IBOutlet weak var lblTotal: DesignableLabel!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var viewRate: UIView!
    @IBOutlet weak var lblSubtotal: DesignableLabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewRate.isHidden = true
        self.dimView.isHidden = true
        self.viewDeliveryTime.isHidden = true
        self.viewDeliveryOption.isHidden = true
        self.stackViewCheck.isHidden = true
    GloDeliveryTime = ""
        self.presenter = CartPresenter.init(delegate: self, viewController: self)
        self.cartTableView.register(UINib(nibName: UITABLEVIEWCELL_IDENTIFIRE.CART, bundle: nil), forCellReuseIdentifier: UITABLEVIEWCELL_IDENTIFIRE.CART)
        
        self.cartTableView.register(UINib(nibName: UITABLEVIEWCELL_IDENTIFIRE.CART_PRICE_Details, bundle: nil), forCellReuseIdentifier: UITABLEVIEWCELL_IDENTIFIRE.CART_PRICE_Details)
        self.cartTableView.estimatedRowHeight = UITableView.automaticDimension
        self.cartTableView.rowHeight = 100
        if fromOrderScreen{
            self.presenter?.repeatOrderCart(orderID: orderID ?? "")
        }else{
             self.presenter?.getCart()
        }
    }
    //MARK:- Button Action
    @IBAction func backButtonDidTap(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
 
    @IBAction func handlecontinueORDER(_ sender: Any) {
        if self.cartList?.ChefData.inChefId != nil{
        self.gotoChefDetailVC(id: (self.cartList?.ChefData.inChefId)!)
        }

    }
    
    @IBAction func handleSelectDelivery(_ sender: Any) {
        if deliveryType == "3" || deliveryType == "" || deliveryType == "0" {
        if heightDeliveryView.constant == 30{
            heightDeliveryView.constant = 60
            heightDeliveryOptions.constant = 30
        }else{
            heightDeliveryView.constant = 30
                       heightDeliveryOptions.constant = 0
        }
        }
    }
    
    @IBAction func handleDeliveryType(_ sender: UIButton) {
        if sender.tag == 222{
            deliveryType = "2"
          //  GloDeliveryTime = ""
            GloOrderType = "2"
            lblSelectDeliveryType.text = "Pickup"
            finalPrice()
        }else{
             deliveryType = "1"
            GloOrderType = "1"
           // GloDeliveryTime = ""
             self.viewDeliveryTime.isHidden = false
            lblSelectDeliveryType.text = "Delivery"
            finalPrice()
            }
    }
  
 
    @IBAction func handleCheckout(_ sender: Any) {
        
        if GloDeliveryTime == ""{
            if self.deliveryType == "" || self.deliveryType == "3" || self.deliveryType == "0" {
                                    self.alert("", message: "Select Delivery Type")
                return
                                }
//            if deliveryType == "2"{
//                  self.gotoAddressView()
//                return
//            }
            self.alert("", message: "Select Delivery Time")
                           return

           
        }
        self.gotoAddressView()
        
    }
    
    @IBAction func handleDeliveryTime(_ sender: Any) {
        doDatePicker()
    }
    @IBAction func handlePromocode(_ sender: Any) {
        gotoPromocodeVC()
    }
    //MARK:- Functions
    func gotoAddressView(){
        if self.cartList != nil{
                  if self.cartList?.cart_total != ""{
                      if self.deliveryType == "" || self.deliveryType == "3" || self.deliveryType == "0" {
                          self.alert("", message: "Select Delivery Type")
                      }
                      let vc = storyboard?.instantiateViewController(withIdentifier: UIVIEWCONTROLLER_IDENTIFIRE.myFoodBegVC) as! myFoodBegVC
                      let aObjNavi = UINavigationController(rootViewController: vc)
                      aObjNavi.modalPresentationStyle = .fullScreen
                      vc.cartTotal = self.cartList?.cart_total ?? ""
                      vc.deliveryType =  lblSelectDeliveryType.text ?? ""
                      vc.deliveryCharge = self.cartList?.settingData.deliveryCharge ?? "0"
                      GloOrderType = self.deliveryType ?? "1"
                      vc.servicefee = self.cartList?.settingData.tax ?? "0"
                      vc.navigationController?.navigationBar.isHidden = true
                      self.present(aObjNavi, animated: true) {
                      }
                  }
              }
    }
    func doDatePicker(){
          
          self.view.endEditing(true)
          viewT.isHidden = false
          viewT.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
          viewT.backgroundColor = UIColor.black.withAlphaComponent(0.5)
          self.view.addSubview(viewT)
          self.datePicker = UIDatePicker(frame:CGRect(x: 0, y: self.viewT.frame.size.height - 200, width: self.view.frame.size.width, height: 200))
          
          self.datePicker?.backgroundColor =  UIColor(red: 1, green: 1, blue: 1, alpha: 1)
          
        self.datePicker?.datePickerMode = UIDatePicker.Mode.dateAndTime
        self.datePicker.minimumDate = Date()
          self.datePicker.timeZone = NSTimeZone.local
         // self.datePicker.locale = Locale(identifier: "az-Arab")
         // az-Arab
          self.datePicker.addTarget(self, action: #selector(self.timeSelected), for: .valueChanged)
          self.datePicker.addTarget(self, action: #selector(self.timeSelected), for: .allEvents)
        
          toolBar.barStyle = .default
          toolBar.frame.size.height = 40
          toolBar.frame =  CGRect(x:0 , y: self.viewT.frame.size.height - self.datePicker.frame.size.height - self.toolBar.frame.size.height, width: self.viewT.frame.size.width, height: 40)
          toolBar.isTranslucent = true
          toolBar.barTintColor =  UIColor(red: 71/255, green: 151/255, blue: 12/255, alpha: 1)
          toolBar.tintColor =  UIColor(red: 0.1201788262, green: 0.694444716, blue: 0.7746556401, alpha: 1)
          toolBar.sizeToFit()
          // Adding Button ToolBar
          let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.doneClick))
          doneButton.tintColor = UIColor.white
          let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
          let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.cancelClick))
          cancelButton.tintColor = UIColor.white
          toolBar.setItems([cancelButton, spaceButton, doneButton], animated: true)
          toolBar.isUserInteractionEnabled = true
          self.toolBar.isHidden = false
          self.viewT.addSubview(toolBar)
          viewT.addSubview(self.datePicker)
          
      }
      @objc func doneClick() {
          let dateFormatter = DateFormatter()
          dateFormatter.dateFormat =  "HH:mm"
          
          let date = dateFormatter.date(from: "17:00")
          
         // datePicker.date = date ?? Date()
        self.checkAvailbility(date: datePicker.date)
          
          viewT.isHidden = true
          self.toolBar.isHidden = true
          
          
      }
    func DateAvailable(date:Date) -> Bool{
        openDays = self.cartList?.ChefData.availablity
        if let arr = openDays?.components(separatedBy: ","){
            if arr.contains(date.getNumberToCompareDate()){
                return true
            }
        }
        return false
    }
    func checkAvailbility(date:Date){
        
              if self.DateAvailable(date: date){
                  //self.view_Available.isHidden = false
                  
              }else{
                  self.alert("", message: "Chef not available on selected date")
                lblDeliveryTime.text = ""
                GloDeliveryTime = ""
              }
    }
      @objc func timeSelected(sender : UIDatePicker){
          let myDateFormatter: DateFormatter = DateFormatter()
          myDateFormatter.dateFormat = Constants.DATE_FORMAT.datePickerTime90
          // get the date string applied date format
          let mySelectedDate: NSString = myDateFormatter.string(from: sender.date) as NSString
              lblDeliveryTime.text = mySelectedDate as String
        GloDeliveryTime = mySelectedDate as String
          }
      

      @objc func cancelClick() {
          let dateFormatter = DateFormatter()
                   dateFormatter.dateFormat =  "HH:mm"
                   
                   let date = dateFormatter.date(from: "17:00")
                   
                  // datePicker.date = date ?? Date()
                 self.checkAvailbility(date: datePicker.date)
                   
                   viewT.isHidden = true
                   self.toolBar.isHidden = true
          
      }
       @objc func backButton()  {
           dismiss(animated: true) {
           }
       }
       func setUpData(){
          finalPrice()
        self.viewRate.isHidden = false
        self.viewDeliveryOption.isHidden = false
        self.viewDeliveryTime.isHidden = false
        self.stackViewCheck.isHidden = false

       }
    func gotoPromocodeVC(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PromocodeViewController") as! PromocodeViewController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false, completion: nil)
    }
    func finalPrice(){
        self.lblSubtotal.text = "$" + (self.cartList?.cart_total ?? "0")
                let sd = self.cartList?.cart_total.FloatValue()
        guard let creditcard = self.cartList?.settingData.creditCardFee.FloatValue() else {return}
               var creditcardFee : Float{
                   return (sd ?? 0)*(creditcard/100)
               }
               let y = String(format:"%.2f", creditcardFee)
               GLoCreditFee = y
               print(y)  // 1.236
               GloSubtotal = self.cartList?.cart_total ?? "0"
               self.LBLserviceFee.text = "$" + "\(y)"
        let deliveryCharge = (self.cartList?.settingData.deliveryCharge ?? "0").FloatValue()
                  self.lblDeliveryCharge.text = "$" + ((GloOrderType == "1" ? ("\(deliveryCharge)") : "0"))
               let total = (GloOrderType == "1" ? (deliveryCharge) : 0) + (GLoCreditFee.FloatValue() ) + ((self.cartList?.cart_total.FloatValue())!)
        let z = String(format:"%.2f", total)
                  self.lblTotal.text = "$" + z
    }
    @objc func handleDecrease(sender:UIButton){
        self.presenter?.updateCartItems(item : self.cartList?.data[sender.tag],IsIncrease : false)
    }
    @objc func handleDelete(sender:UIButton){
                    Alert().OKAlertControllerCustom(Message: "Remove item from Cart", okText: "Yes", alertMsg: "") {
                        self.presenter?.updateCartItems(item : self.cartList?.data[sender.tag],IsIncrease : nil)
        }

    }
    @objc func handleIncrease(sender:UIButton){
        self.presenter?.updateCartItems(item : self.cartList?.data[sender.tag],IsIncrease : true)
    }
    func gotoChefDetailVC(id: String) {
            let chefDetailsVC = self.storyboard?.instantiateViewController(withIdentifier: UIVIEWCONTROLLER_IDENTIFIRE.CHEF_DETAILS)as! ZFUChefDetailsVC
            chefDetailsVC.chefId = id
    GlofromSearchList = false
       // let nav = UINavigationController(rootViewController: chefDetailsVC)
                  chefDetailsVC.modalPresentationStyle = .overFullScreen
       // self.navigationBar.isHidden = true
                  self.present(chefDetailsVC, animated: true, completion: nil)
        }
}

extension ZFUCartVC: UITableViewDataSource,UITableViewDelegate {
    //MARK:- UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cartList?.data.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITABLEVIEWCELL_IDENTIFIRE.CART, for: indexPath) as! CartItemTableViewCell
        cell.addDATA(data: (self.cartList?.data[indexPath.row])!)
        cell.btnDecrease.tag = indexPath.row
        cell.btnIncrease.tag = indexPath.row
        cell.btnDelete.tag = indexPath.row
        cell.btnDelete.addTarget(self, action: #selector(self.handleDelete(sender:)), for: .touchUpInside)
        cell.btnIncrease.addTarget(self, action: #selector(self.handleIncrease(sender:)), for: .touchUpInside)
        cell.btnDecrease.addTarget(self, action: #selector(self.handleDecrease(sender:)), for: .touchUpInside)
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            Alert().OKAlertControllerCustom(Message: "Remove item from Cart", okText: "Yes", alertMsg: "") {
                self.presenter?.updateCartItems(item : self.cartList?.data[indexPath.row],IsIncrease : nil)
            }
    }
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 130
        }
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        }
}

//MARK:- CART DATA PROTOCOL
extension ZFUCartVC : CartProtocol{
    func success(data: Model_CART?) {
        self.noitemView.isHidden = true
        if let datainfo = data{
        self.cartList = datainfo
            self.deliveryType = datainfo.ChefData.order_type
                           if datainfo.ChefData.order_type != "3" && datainfo.ChefData.order_type != "" && datainfo.ChefData.order_type != "0" {
                               self.lblSelectDeliveryType.text = datainfo.ChefData.order_type == "1" ? "Delivery":"Pickup"
                        
                            if datainfo.settingData != nil{
                                 GloDeliveryCharge = datainfo.settingData.deliveryCharge
                            }else{
                                 GloDeliveryCharge = "0"
                            }
                            if datainfo.ChefData.order_type == "2"{
                                GloDeliveryCharge = "0"
                            }
                            GloOrderType = datainfo.ChefData.order_type 
                            GLoCreditFee = datainfo.settingData.creditCardFee
                            GloServiceCharge = datainfo.settingData.tax
                           }else{
                            if datainfo.settingData != nil{
                                                            GloDeliveryCharge = datainfo.settingData.deliveryCharge
                                                       }else{
                                                            GloDeliveryCharge = "0"
                                                       }
                                                       GLoCreditFee = datainfo.settingData.creditCardFee
                                                       GloServiceCharge = datainfo.settingData.tax
            
            }
        self.cartTableView.reloadData()
            self.setUpData()
        }
    }
    func failer(msg: String) {
        self.noitemView.isHidden = false
        self.view.bringSubviewToFront(noitemView)
        //self.errorNotice(msg)
    }
}
extension ZFUCartVC : GotoChefDetailDelegate{
//MARK:- GotoChefDetail

func gotoChefDetail(id: String) {
    self.dimView.isHidden = true
   // self.lblDeliveryTime.text = GloDeliveryTime
}
}
