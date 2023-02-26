//
//  OrdersTableViewController.swift
//  HotCoffee
//
//  Created by Toan Phan Nguyen Song on 22/02/2023.
//

import UIKit

class OrdersTableViewController: UITableViewController {

    private var orderListViewModel: OrderListViewModel = OrderListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        LocalService.shared.loadOrders() {[weak self] result in
            switch result{
            case .success(let orders):
                self?.orderListViewModel.ordersViewModels = orders.map(OrderViewModel.init)
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
       
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navC = segue.destination as? UINavigationController, let addOrderViewController = navC.viewControllers.first as? AddOrderViewController else{
            return
        }
        
        addOrderViewController.delegate = self
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
        let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultTableViewCell", for: indexPath)
        let vm = orderListViewModel.orderViewModel(at: indexPath.row)
        cell.textLabel?.text = vm.name
        cell.detailTextLabel?.text = vm.coffeeType
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderListViewModel.ordersViewModels.count
    }
}

extension OrdersTableViewController: AddOrderViewControllerDelegate{
    func addOrderViewControllerDidClose(_ controller: AddOrderViewController) {
        controller.dismiss(animated: true)
    }
    
    func addOrderViewControllerDidSave(_ controller: AddOrderViewController, order: Order) {
        controller.dismiss(animated: true)
        let newViewModel = OrderViewModel(order: order)
        orderListViewModel.ordersViewModels.append(newViewModel)
        
        tableView.insertRows(at: [IndexPath.init(row: orderListViewModel.ordersViewModels.count - 1, section: 0)], with: .automatic)
    }
    
    
}
