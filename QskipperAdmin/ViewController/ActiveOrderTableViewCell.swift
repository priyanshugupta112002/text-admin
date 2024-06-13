//
//  ActiveOrderTableViewCell.swift
//  QskipperAdmin
//
//  Created by Batch-1 on 13/06/24.
//

import UIKit

class ActiveOrderTableViewCell: UITableViewCell {
    
    
    
    @IBOutlet var OrderItem: UILabel!
    @IBOutlet var OrderAmount: UILabel!
    @IBOutlet var OrderPacked: UILabel!
    @IBOutlet var OrderStatus: UILabel!
    @IBOutlet var OrderPlaced: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func OrderPlaced(_ sender: UIButton) {
        
        async {
            do {
                try await productApi.shared.OrderComplete()
                
                
                debugPrint("order Complete")
                
                await MainActor.run {
                    OrderStatus.text = "Completed"
                    OrderPlaced.isHidden = true
                    
                }
            } catch {
                print("Error fetching orders:", error)
            }
        }
        
        
        
        
    }
    
}
