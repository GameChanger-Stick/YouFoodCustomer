
import Foundation
import Stripe
protocol PaymentDelegate {
    func success(msg:String)
    func fail(reason:String)
}
class stripPayment{
    var delegate : UIViewController
    let stripeCardParams = STPCardParams()
    var cartDate : Model_CART?
   var payment_Delegate: PaymentDelegate?
    init(delegate:UIViewController) {
        self.delegate = delegate
    }

    func paymentRequest(token:String){
//        if validateCard(name: name, cardumber: cardnumber, Month: Month, Year: Year, Cvv: Cvv){
//        let expMonth = UInt(Month.IntValue())
//        let expYear = UInt(Year.IntValue())
//        stripeCardParams.number = cardnumber
//                    stripeCardParams.cvc = Cvv
//                    stripeCardParams.expMonth = expMonth
//                    stripeCardParams.expYear = expYear
//        let config = STPPaymentConfiguration.shared()
//        let stpApiClient = STPAPIClient.init(configuration: config)
//        stpApiClient.createToken(withCard: stripeCardParams) { (token, error) in
//        if error == nil {
        //Success
        DispatchQueue.main.async {
            
                self.CreateOrder(loader: true, token: token)
//            }else{
//                self.payment_Delegate!.fail(reason: "Token Failed")
//            }
       // }
//        }else{
//            self.payment_Delegate!.fail(reason: error.debugDescription)
//            }
            }
            
       // }
        
    }
    
    func validateCard(name:String,cardumber:String,Month:String,Year:String,Cvv:String) -> Bool{
            if name == ""{
                payment_Delegate!.fail(reason: "Enter name")
                return false
            }else if cardumber == ""{
                payment_Delegate!.fail(reason: "Enter Valid Card number")
                 return false
            }else if Month == ""{
                payment_Delegate!.fail(reason: "Enter expire date")
                 return false
            }else if Year == ""{
                payment_Delegate!.fail(reason: "Enter expire date")
                 return false
            }else if Cvv == ""{
                payment_Delegate!.fail(reason: "Enter CVV")
                 return false
            }else{
                return true
            }
               
    }
    func getTotal(){
        if cartDate != nil{
            let total = GLoCreditFee.IntValue() + GloServiceCharge.IntValue() + (self.cartDate?.cart_total ?? "0").IntValue()
        //   GloTotalAmount = total.StringValue()
//            GloDeliveryCharge = 49.StringValue()
//            GloServiceCharge = 30.StringValue()
            
        }
        
    }
    func CreateOrder(loader:Bool,token:String){
        if cartDate == nil{
            delegate.alertResponse(message: "can't get Cart data")
            return
        }
        self.getTotal()
        var dict = ["userid":(currentUser?.info.inUserId)!,
                      "chefid":self.cartDate?.data[0].in_chef_Id!,
                      "stripeToken":token,
                      "delivery_charge":GloDeliveryCharge,
                      "total_amount":GloTotalAmount,
                      "address1":GloAddress1,
                      "address2":GloAddress2,
                      "lat":GloLat,"lng":GloLng,
                      "payment_method":"online",
                      "order_type":GloOrderType,
                      "comment":"","order_date":GloDeliveryTime.convertTOFormat(from: "MM-dd-yyyy HH:mm", to: Constants.DATE_FORMAT.dateformattMain),
                      "dicount_val":"",
                      "credit_card_fee":GLoCreditFee,
        "cart_total":GloSubtotal]
        if GloTotalAmount == "0" || GloTotalAmount == "0.0"{
            dict["free"] = "1"
        }
        APIServices().CreateOrder(params:dict as! [String : String] ,loader:loader , viewController: delegate) { (result) in
            self.payment_Delegate!.success(msg: result?.msg ?? "")

             
          }
      }
      
}
