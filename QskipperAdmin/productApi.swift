//
//  productApi.swift
//  QskipperAdmin
//
//  Created by Batch-1 on 03/06/24.
//

import Foundation

class productApi{
    
    static let shared = productApi()
    let baseUrl = URL(string: "https://queueskipperbackend.onrender.com/")!
    
    
    enum productApiError : Error , LocalizedError{
        case productNotFound
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

//        print(userResponse)

        
        
        return userResponse.products
        
    }

    
}


