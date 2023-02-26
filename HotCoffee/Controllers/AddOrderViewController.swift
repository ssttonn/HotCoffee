//
//  AddOrderViewController.swift
//  HotCoffee
//
//  Created by Toan Phan Nguyen Song on 22/02/2023.
//

import Foundation
import UIKit

protocol AddOrderViewControllerDelegate{
    func addOrderViewControllerDidClose(_ controller: AddOrderViewController)
    func addOrderViewControllerDidSave(_ controller: AddOrderViewController, order: Order)
}


class AddOrderViewController: UIViewController{
    private var vm = AddCoffeeOrderViewModel()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextFiend: UITextField!
    
    var delegate: AddOrderViewControllerDelegate!
    
    private var coffeeSizesSegmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        setupSegmentedControl()
    }
    
    func setupSegmentedControl(){
        coffeeSizesSegmentedControl = UISegmentedControl(items: vm.sizes)
        view.addSubview(coffeeSizesSegmentedControl)
        coffeeSizesSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        coffeeSizesSegmentedControl.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 20).isActive = true
        coffeeSizesSegmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    @IBAction func close(){
        guard let delegate = delegate else{
           return
        }
        delegate.addOrderViewControllerDidClose(self)
    }
    
    @IBAction func save(){
        guard let coffeeTypeIndexPath = tableView.indexPathForSelectedRow else{
            return
        }
        vm.name = nameTextField.text
        vm.email = emailTextFiend.text
        vm.selectedCoffeeSize = vm.sizes[self.coffeeSizesSegmentedControl.selectedSegmentIndex]
        vm.selectedCoffeeType = vm.types[coffeeTypeIndexPath.row]
        let newOrder = Order(vm)
        LocalService.shared.addNewOrder(order: newOrder){result in
            switch result{
            case .success():
                delegate?.addOrderViewControllerDidSave(self, order: newOrder)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension AddOrderViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CoffeeTypeTableViewCell", for: indexPath)
        cell.textLabel?.text = self.vm.types[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vm.types.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
}
