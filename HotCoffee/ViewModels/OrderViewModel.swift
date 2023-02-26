//
//  OrderViewModel.swift
//  HotCoffee
//
//  Created by Toan Phan Nguyen Song on 25/02/2023.
//

import Foundation

struct OrderListViewModel{
    var ordersViewModels: [OrderViewModel]
    
    init(){
        self.ordersViewModels = [OrderViewModel]()
    }
}

extension OrderListViewModel{
    func orderViewModel(at index: Int)-> OrderViewModel{
        return self.ordersViewModels[index]
    }
}

struct OrderViewModel{
    let order: Order
}

extension OrderViewModel{
    var name: String{
        return order.name
    }
    
    var email: String{
        return order.email
    }
    
    var coffeeType: String{
        return order.type.rawValue.capitalized
    }
    
    var coffeeSize: String{
        return order.size.rawValue.capitalized
    }
}

