//
//  product.swift
//  QskipperAdmin
//
//  Created by Batch-1 on 24/05/24.
//

import Foundation

import UIKit

struct Product :Codable {
    var _id:String = ""
    var product_photo: UIImage?
    var product_photo64Image: String = ""
    var restaurant_id: String = ""
    var product_name: String = ""
    var product_price: Int = 0
    var extraTime: Double = 0.0
    var rating: Double = 0
    var availability:Bool = true
    var food_category:String = ""
    var description :String = ""
    var featured :Bool = false
    
    
    enum CodingKeys :String , CodingKey{
        case _id
        case product_name
        case restaurant_id
        case product_price
        case food_category
        case description
        case availability
    }
}


struct ProductResponse:Codable{
    var products:[Product]
    
    enum CodingKeys :String , CodingKey{
        case products
    }
}

struct imageResponse:Codable{
    let product_photo:Image
    
    enum CodingKeys : String ,CodingKey{
        case product_photo
        
    }
}

struct Image :Codable{
    
    var banner_photo64: UIImage
    enum CodingKeys:String ,CodingKey{
        case banner_photo64
    }
    
    init(from decoder: Decoder) throws {
           let container = try decoder.container(keyedBy: CodingKeys.self)
           let product_photo64Image = try container.decode(String.self, forKey: .banner_photo64)
           
           guard let imageData = Data(base64Encoded: product_photo64Image),
               let photo = UIImage(data: imageData)else {
               throw DecodingError.dataCorruptedError(forKey: .banner_photo64, in: container, debugDescription: "Image is corrupted")
           }
        self.banner_photo64 = photo
       }
       
       // Custom encoding
       func encode(to encoder: Encoder) throws {
           var container = encoder.container(keyedBy: CodingKeys.self)
           let imageData = banner_photo64.pngData()
           let base64String = imageData?.base64EncodedString() ?? ""
           try container.encode(base64String, forKey: .banner_photo64)
       }
    
}
