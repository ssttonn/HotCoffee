//
//  AddCoffeeOrderViewModel.swift
//  HotCoffee
//
//  Created by Toan Phan Nguyen Song on 25/02/2023.
//

import Foundation

struct AddCoffeeOrderViewModel{
    var name: String?
    var email: String?
    var selectedCoffeeType: String?
    var selectedCoffeeSize: String?
    
    var types: [String] {
        return CoffeeType.allCases.map{$0.rawValue.capitalized}
    }
    
    var sizes: [String] {
        return CoffeeSize.allCases.map{$0.rawValue.capitalized}
    }
}
