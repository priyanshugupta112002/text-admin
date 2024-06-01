//
//  product.swift
//  QskipperAdmin
//
//  Created by Batch-1 on 24/05/24.
//

import Foundation

import UIKit

struct Product :Codable {
    
    var product_photo: UIImage? {
        didSet {
            if let image = product_photo {
                product_photo64Image = image.pngData()?.base64EncodedString() ?? ""
            } else {
                product_photo64Image = ""
            }
        }
    }
    var product_photo64Image: String = ""
    var restaurant_id: String = "665acaee5b7b343d44c639de"
    var product_name: String = ""
    var product_price: Int = 0
    var extraTime: Double = 0.0
    var rating: Int = 0
    var availability:Bool = true
    var food_category:String = ""
    var description :String = ""
    
    
    enum CodingKeys :String , CodingKey{
        case product_name
        case product_photo64Image
        case restaurant_id
        case product_price
        case extraTime
        case food_category
        case description
        
    }

}



