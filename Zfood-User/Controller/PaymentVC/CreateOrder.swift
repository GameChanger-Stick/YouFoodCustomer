//
//  CreateOrder.swift
//  Zfood-User
//
//  Created by bhavya on 1/21/20.
//  Copyright © 2020 WemakeAppz. All rights reserved.
//

import Foundation
protocol CreateOrderProtocol {
    func successOrder()
    func failOrder(reason:String)
}
//class CreateOrderPresenter{
//    
//    var delegate_order : CreateOrderProtocol?
//    init(parameters) {
//        statements
//    }
//}
