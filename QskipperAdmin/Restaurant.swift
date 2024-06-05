

import Foundation
import UIKit

struct Restaurant: Codable {
    var user: String = ""
    var restaurant_Name: String = ""
    var banner_photo: UIImage? {
        didSet {
            if let image = banner_photo {
                if let compressedData = compressImage(image: image, maxSizeInBytes: 50 * 1024) {
                    // Use the compressed data
                    let banner_photo = createImage(from: compressedData)
                } else {
                    print("Compression failure")
                }
            }
        }
    }

    
    var bannerPhoto64Image: UIImage?
    var cuisine: String = ""
    var estimatedTime: Int = 10
    var dish: [Dish] = []
    var rating: Double = 0.0

    enum CodingKeys: String, CodingKey {
        case user
        case restaurant_Name
        case bannerPhoto64Image
        case cuisine
        case estimatedTime
        case dish
        case rating
        
    }

    init() {}

    init(from decoder: Decoder) throws {
        // Your existing init(from:) implementation
    }

    func encode(to encoder: Encoder) throws {
        // Your existing encode(to:) implementation
    }
}

func compressImage(image: UIImage, maxSizeInBytes: Int) -> Data? {
    var compression: CGFloat = 1.0
    var imageData = image.jpegData(compressionQuality: compression)
    
    while let data = imageData, data.count > maxSizeInBytes && compression > 0 {
        compression -= 0.1
        imageData = image.jpegData(compressionQuality: compression)
    }
    
    return imageData
}
func createImage(from compressedData: Data) -> UIImage? {
    return UIImage(data: compressedData)
}



struct Dish: Codable {
    var image: String
    var name: String
    var description: String
    var price: Int
    var rating: Double
    var foodType: String

    enum CodingKeys: String, CodingKey {
        case image
        case name
        case description
        case price
        case rating
        case foodType
    }
}

var Cuisine: [String] = ["North India", "South Indian", "Chinese", "Fast Food"]



