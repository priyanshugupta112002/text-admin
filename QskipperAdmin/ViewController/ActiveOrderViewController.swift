

import UIKit

class ActiveOrderViewController:UIViewController, UITableViewDataSource, UITableViewDelegate {
    


    
    
    
    
    @IBOutlet var activeOrderTableView: UITableView!
    


    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return DataControlller.shared.order.order. Using actual count of data
        return DataControlller.shared.orderRes.order.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ActiveOrder", for: indexPath) as! ActiveOrderTableViewCell
        
        let cuisineTypeForThisCell = DataControlller.shared.orderRes.order[indexPath.row]
        var content = cell.defaultContentConfiguration()
        
        debugPrint( cuisineTypeForThisCell)
        cell.OrderAmount.text = "\(cuisineTypeForThisCell.totalPrice)"
        cell.OrderStatus.text = cuisineTypeForThisCell.status
        let orderText  = DataControlller.shared.orderRes.order[indexPath.row].items.map{"\(String(describing: $0.quantity)) x \($0.product_name)"}
        
        cell.OrderItem.text = orderText.joined(separator: "\n")

        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        250
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activeOrderTableView.delegate = self
        activeOrderTableView.dataSource = self
        
        async {
            do {
                let response = try await productApi.shared.getAllOrder()
                
                DataControlller.shared.set_orderResponse(getAllorder: response)
                debugPrint("order placed")
                debugPrint(DataControlller.shared.orderRes)
                
                
                await MainActor.run {
                    self.activeOrderTableView?.reloadData()
                }
            } catch {
                print("Error fetching orders:", error)
            }
        }
    }
    
    
    
        
    }
    
    
    

