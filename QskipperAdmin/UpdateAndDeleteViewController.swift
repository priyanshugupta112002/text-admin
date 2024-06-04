//
//  UpdateAndDeleteViewController.swift
//  QskipperAdmin
//
//  Created by Batch-1 on 03/06/24.
//

import UIKit

class UpdateAndDeleteViewController: UIViewController {
    
    
    var currentProduct = Product()
    
    
    @IBOutlet var Product_Image: UIImageView!
    @IBOutlet var Product_Name: UITextField!
    @IBOutlet var Product_Price: UITextField!
    @IBOutlet var Product_Description: UITextView!
    @IBOutlet var Product_Category: UITextField!
    @IBOutlet var Product_ExtraTime: UITextField!
    @IBOutlet var Product_IsAvailable: UISwitch!
    @IBOutlet var Product_featured: UISwitch!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        Product_Image.image = currentProduct.product_photo
        Product_Name.text = currentProduct.product_name
        Product_Price.text = "\(currentProduct.product_price)"
        Product_Description.text = currentProduct.description
        Product_Category.text = currentProduct.description
        Product_featured.isOn = false
        Product_IsAvailable.isOn = true
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func DoneButtonTapped(_ sender: Any) {
        
        
        currentProduct.product_name = Product_Name.text!
        currentProduct.product_price = Int(Product_Price.text!)!
        
        currentProduct.description = Product_Description.text!
        currentProduct.food_category = Product_Category.text!
        
        currentProduct.extraTime = Double(Product_ExtraTime.text!)!
     
        if(Product_featured.isOn){
            currentProduct.featured = true
        }else{
            currentProduct.featured = false
        }
        if(Product_IsAvailable.isOn){
            currentProduct.availability = true
        }else{
            currentProduct.availability = false
        }
        
        
//        Task{
//
//            do {
//                // update Product  user
//               
//                if let response = try await  productApi.shared.updateImformation(currentProduct: currentProduct) {
//                    
//                    await MainActor.run {
//                        
//                    }
//                }
//            } catch {
//                await MainActor.run {
//                    // Handle errors on the main thread
//                    print("Product update failed: \(error)")
//                }
//            }
//            
//        }
        
        

           
    }
    
    
    
    

}
