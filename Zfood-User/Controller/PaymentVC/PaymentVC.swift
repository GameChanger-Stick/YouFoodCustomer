//
///
import UIKit

class PaymentVC: UIViewController {
    var makingPurchase = false
    var paymentPresenter : stripPayment?
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblNavTitle: UILabel!
    @IBOutlet weak var lblLAbel: UILabel!
    @IBOutlet weak var btnPAy: UIButton!
    var selectedToken = ""
    var presenterCart : CartPresenter?
    var cardListArr : ModelCARDLIST?
    var selectedIndex :Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenterCart = CartPresenter.init(delegate: self, viewController: self)
        self.presenterCart?.getCart()
        paymentPresenter = stripPayment.init(delegate: self)
        paymentPresenter?.payment_Delegate = self
        self.tableView.register(UINib(nibName: "cell_paymentVC", bundle: nil), forCellReuseIdentifier: "cell_paymentVC")
        if makingPurchase{
            lblNavTitle.text = "PAYMENT"
            btnPAy.isHidden = false
            lblLAbel.isHidden = false
        }else{
              lblNavTitle.text = "My Card"
              btnPAy.isHidden = true
            lblLAbel.isHidden = true
        }
       
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
         self.MYCardList(loader: true)
    }
   //MARK:-Button ACTION
    func gotoMyorder(){
          let appDelegate = UIApplication.shared.delegate as! AppDelegate
               appDelegate.setOrderViewController()
       //        let login = self.storyboard?.instantiateViewController(withIdentifier: UIVIEWCONTROLLER_IDENTIFIRE.ORDERS) as! ZFUOrdersVC
       //        self.navigationController?.present(login, animated: true, completion: nil)
             }
    
    @IBAction func handlePayNow(_ sender: Any) {
        if self.selectedIndex != nil{
            self.paymentPresenter?.CreateOrder(loader: true, token: self.cardListArr?.data[selectedIndex!].customerId ?? "")
        }else{
                               self.showErrorGreen(msg: "Select/Add Card")

        }
    }
    @IBAction func handleBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func handleAddCArd(_ sender: Any) {
       gotoAddCard()
    }
    //MARK:- Function
    func MYCardList(loader:Bool){
        let dict = ["user_id":(currentUser?.info.inUserId)!]
        APIServices().MY_CARD(params:dict ,loader:loader , viewController: self) { (result) in
            if result == nil{
                if self.cardListArr != nil{
                    self.cardListArr?.data.removeAll()}
                               self.tableView.reloadData()
            }else{
                self.cardListArr = result
                self.tableView.reloadData()
            }
        }
    }
    func removewCArd(id:String){
        let dict = ["user_id":(currentUser?.info.inUserId)!,"card_id":id]
        APIServices().RemoveCard(params:dict ,loader:true, viewController: self) { (result) in
            self.MYCardList(loader: true)
        }
    }
    func gotoAddCard(){
        if #available(iOS 13.0, *) {
            let vc = self.storyboard?.instantiateViewController(identifier: "cardScreenVC") as! cardScreenVC
            vc.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "cardScreenVC") as! cardScreenVC
                      vc.modalPresentationStyle = .fullScreen
             self.navigationController?.pushViewController(vc, animated: true)
        }
       
    }
    func paymemtRequest(){
        self.paymentPresenter?.paymentRequest(token: (self.cardListArr?.data[selectedIndex!].customerId)!)
    }
   
}
extension PaymentVC : UITableViewDelegate,UITableViewDataSource{
     //MARK:-UITableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cardListArr?.data.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell_paymentVC", for: indexPath) as! cell_paymentVC
        cell.addData(card: self.cardListArr?.data[indexPath.row])
        
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        for index in (0...((self.cardListArr?.data.count)! - 1)){
            if index == indexPath.row{
                
                 self.cardListArr?.data[index].isSelected = true
            }else{
                 self.cardListArr?.data[index].isSelected = false
            }
            self.selectedIndex = indexPath.row
        }
       
        tableView.reloadData()
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            self.removewCArd(id: self.cardListArr?.data[indexPath.row].id ?? "")
        }
    }
}
extension PaymentVC : PaymentDelegate{
    func success(msg: String) {
        self.showSuccessWithBtn(msg: msg , completion: {
                        self.gotoMyorder()
                     })
       // alertResponse(message: msg)
    }
    
    func fail(reason: String) {
        alertResponse(message: reason)
    }
    
    
}
extension PaymentVC : CartProtocol{
    func success(data: Model_CART?) {
        paymentPresenter!.cartDate = data
    }
    
    func failer(msg: String) {
     //   self.errorNotice(msg)
    }
}
