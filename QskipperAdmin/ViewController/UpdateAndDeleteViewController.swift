//
//  UpdateAndDeleteViewController.swift
//  QskipperAdmin
//
//  Created by Batch-1 on 03/06/24.
//

import UIKit
import MultipartFormDataKit

class UpdateAndDeleteViewController: UIViewController {
    
    
    var currentProduct = Product()
    var index = -1
    
    
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
        Product_ExtraTime.text = "\(currentProduct.extraTime)"
        Product_featured.isOn = false
        Product_IsAvailable.isOn = true
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func DoneButtonTapped(_ sender: UIButton) {
        
        
        //        currentProduct.product_name = Product_Name.text!
        //        currentProduct.product_price = Int(Product_Price.text!)!
        //        
        //        currentProduct.description = Product_Description.text!
        //        currentProduct.food_category = Product_Category.text!
        //        
        //        currentProduct.extraTime = Int(Product_ExtraTime.text!)!
        //     
        //        if(Product_featured.isOn){
        //            currentProduct.featured = true
        //        }else{
        //            currentProduct.featured = false
        //        }
        //        if(Product_IsAvailable.isOn){
        //            currentProduct.availability = true
        //        }else{
        //            currentProduct.availability = false
        //        }
        //        
        //        
        //        if let formData = updateFormAppData(image:currentProduct.product_photo!, ProductName: Product_Name.text! , prepTime: Int(Product_ExtraTime.text!)! ,productPrice: Int(Product_Price.text!)! , ProductCategory: Product_Category.text! , ProductDescription: Product_Description.text!   ) {
        //            
        //        debugPrint("done button")
        //            var request = URLRequest(url: URL(string: "https://trout-worst-halloween-palmer.trycloudflare.com/update-food/\(currentProduct._id)")!)
        //              request.httpMethod = "PUT"
        //        
        //            request.setValue(formData.contentType, forHTTPHeaderField: "Content-Type")
        //
        //            request.httpBody = formData.body
        //
        //              URLSession.shared.dataTask(with: request) { (data, response, error) in
        //                  if let error = error {
        //                      print("Error: \(error.localizedDescription)")
        //                      return
        //                  }
        //                  // Handle response
        //                  if let data = data, let responseString = String(data: data, encoding: .utf8) {
        //                      print("Response: \(responseString)")
        //                  }
        //              }.resume()
        //          } else {
        //              print("Failed to create form data.")
        //          }
        //      }
        
        
        
        
        //   
        //           
        //    func updateFormAppData(image: UIImage ,  ProductName: String, prepTime: Int , productPrice:Int , ProductCategory:String ,ProductDescription :String ) -> MultipartFormData.BuildResult? {
        //
        //
        //        let multipartFormData = try? MultipartFormData.Builder.build(
        //            with: [
        //                (
        //                    name: "product_name",
        //                    filename: nil,
        //                    mimeType: nil,
        //                    data: ProductName.data(using: .utf8)!
        //                ),
        //                (
        //                    name: "description",
        //                    filename: nil,
        //                    mimeType: nil,
        //                    data: ProductDescription.data(using: .utf8)!
        //                ),
        //                (
        //                    name: "food_category",
        //                    filename: nil,
        //                    mimeType: nil,
        //                    data: ProductCategory.data(using: .utf8)!
        //                ),
        //                (
        //                    name: "extraTime",
        //                    filename: nil,
        //                    mimeType: nil,
        //                    data: "\(prepTime)".data(using: .utf8)!
        //                ),
        //                (
        //                    name: "product_price",
        //                    filename: nil,
        //                    mimeType: nil,
        //                    data: "\(productPrice)".data(using: .utf8)!
        //                ),
        //                (
        //                    name: "product_photo64Image",
        //                    filename: "example.jpeg",
        //                    mimeType: MIMEType.imageJpeg,
        //                    data: image.jpegData(compressionQuality: 0.1)!
        //                ),
        //                
        //            ],
        //            willSeparateBy: RandomBoundaryGenerator.generate()
        //        )
        //        
        //        return multipartFormData
        //    }
        //    
        //    
        
    }
}



