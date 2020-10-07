
protocol CartProtocol {
    func success(data:Model_CART?)
    func failer(msg:String)
}


class CartPresenter{
    var delegate : CartProtocol
    var viewCotroller : UIViewController
    init(delegate:CartProtocol,viewController:UIViewController) {
        self.delegate = delegate
    self.viewCotroller = viewController
    }
    
    func updateCartItems(item : CartData?,IsIncrease:Bool?){
        if IsIncrease != nil{
        let number = item?.qty
        let intNum = Int(number ?? "1")
        let nwNumber = IsIncrease! ? (intNum! + 1): (intNum! - 1)
        let param = ["user_id":currentUser?.info.inUserId ?? "","cart_id":item?.id! ?? "","lat":GloLat,"lng":GloLng,"qty":String(nwNumber)] as [String : Any]
        APIServices().UPDATE_CART_LIST(params: param, viewController: viewCotroller, loader: true) { (data, error) in
            if data != nil{
                                self.delegate.success(data: data!)
                           }else{
                               self.delegate.failer(msg: "noitem")
                           }
        }
        }else{
            let param = ["user_id":currentUser?.info.inUserId ?? "","cart_id":item?.id! ?? "","qty":"0","lat":GloLat,"lng":GloLng] as [String : Any]
            APIServices().UPDATE_CART_LIST(params: param, viewController: viewCotroller, loader: true) { (data, error) in
                if data != nil{
                     self.delegate.success(data: data!)
                }else{
                    self.delegate.failer(msg: "noitem")
                }
               
        }
        }}
    
    func getCart(){
        let param = ["user_id":currentUser?.info.inUserId ?? "","lat":GloLat,"lng":GloLng] as [String : Any]
        APIServices().GET_CART_LIST(params: param, viewController: viewCotroller, loader: true) { (data, error) in
            if data != nil{
                 self.delegate.success(data: data!)
            }else{
                 self.delegate.failer(msg: "No item in Cart")
            }
           
        }
    }
    func repeatOrderCart(orderID:String){
        
        let param = ["user_id":currentUser?.info.inUserId ?? "","lat":GloLat,"lng":GloLng,"order_id":orderID] as [String : Any]
            APIServices().GET_CART_LIST(params: param, viewController: viewCotroller, loader: true) { (data, error) in
                if data != nil{
                     self.delegate.success(data: data!)
                }else{
                     self.delegate.failer(msg: "No item in Cart")
                }
               
            }

    }
}
