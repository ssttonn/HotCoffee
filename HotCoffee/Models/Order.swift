//
//  Order.swift
//  HotCoffee
//
//  Created by Toan Phan Nguyen Song on 23/02/2023.
//

import Foundation

enum CoffeeType: String, Codable, CaseIterable{
    case cappuccino
    case latte
    case expressino
    case cortado
}

enum CoffeeSize: String, Codable, CaseIterable{
    case small
    case medium
    case large
}

struct Order: Codable{
    let name: String
    let email: String
    let type: CoffeeType
    let size: CoffeeSize
}

extension Order {
    init(_ viewModel: AddCoffeeOrderViewModel) {
        self.name = viewModel.name!
        self.email = viewModel.email!
        
        
        self.type = CoffeeType.init(rawValue: viewModel.selectedCoffeeType!.lowercased())!
        self.size = CoffeeSize.init(rawValue: viewModel.selectedCoffeeSize!.lowercased())!
    }
}
