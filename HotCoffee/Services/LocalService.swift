//
//  LocalService.swift
//  HotCoffee
//
//  Created by Toan Phan Nguyen Song on 25/02/2023.
//

import Foundation

struct LocalService{
    static var shared = LocalService()
    
    private var orders: [Order] = [
        Order(name: "Sample order 1", email: "sampleorder1@gmail.com", type: .cappuccino, size: .large)
    ]
    
    func loadOrders(completion: (Result<[Order], Error>)-> Void){
        completion(.success(orders))
    }
    
    mutating func addNewOrder(order: Order, completion: (Result<Void, Error>)-> Void){
        orders.append(order)
        completion(.success(()))
    }
}
