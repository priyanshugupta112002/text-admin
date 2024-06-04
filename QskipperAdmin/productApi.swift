//
//  productApi.swift
//  QskipperAdmin
//
//  Created by Batch-1 on 03/06/24.
//

import Foundation
import UIKit

class productApi{
    
    static let shared = productApi()
    let baseUrl = URL(string: "https://queueskipperbackend.onrender.com/")!
    
    
    enum productApiError : Error , LocalizedError{
        case productNotFound
        case ImageNotFound
        case productCanNotUpdated
    }
    
    
    func getAllProduct() async throws -> [Product] {
        let productUrl = baseUrl.appendingPathComponent("get_all_product/\(DataControlller.shared.product.restaurant_id)")
        let request = URLRequest(url:productUrl)
        
        let(data , response) = try await URLSession.shared.data(for: request)
        
        if let string = String(data: data, encoding: .utf8)
        {
           debugPrint(string)
        }
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else{
            
            throw productApiError.productNotFound
           
        }
        let decoder = JSONDecoder()
        let userResponse = try decoder.decode(ProductResponse.self, from: data)

        return userResponse.products
    }
    
    
    func fetchImage(from url :URL) async throws -> UIImage{
        
        let(data , response) = try await URLSession.shared.data(from: url)
        
        if let string = String(data: data, encoding: .utf8)
        {
           debugPrint(string)
        }
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else{
            
            throw productApiError.ImageNotFound
        }
        let decoder = JSONDecoder()
        let productImage = try decoder.decode(imageResponse.self, from: data)

        return productImage.product_photo.banner_photo64
        
    }
    
  
    func updateImformation(currentproduct:Product) async throws {
        let registerUrl = baseUrl.appendingPathComponent("update-photo")
        var request = URLRequest(url:registerUrl)
        var item = currentproduct
        request.httpMethod = "POST"
        
        request.setValue("application/json", forHTTPHeaderField:  "Content-Type")
      
        let jsonEncoder = JSONEncoder()
        let jsonData = try? jsonEncoder.encode(item)
        request.httpBody = jsonData
        
        let(data , response) = try await URLSession.shared.data(for: request)
        
        
        if let string = String(data: data, encoding: .utf8)
        {
           debugPrint(string)
        }
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 202 else{
            
            throw productApiError.productCanNotUpdated
        }
        let decoder = JSONDecoder()
        let userResponse = try decoder.decode(User.self, from: data)
        print(userResponse)
        print("ccwdcd")

        
    }

    
}


