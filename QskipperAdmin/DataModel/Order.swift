
import Foundation

struct orderResponse:Codable{
    var id:String = ""

    var order :[OrderProduct ] = []

        enum  CodingKeys: String, CodingKey {
        case id = "_id"
        case order
    }

    
}
struct OrderProduct:Codable{
    var status:String = ""
    var totalPrice :Int = 0
    var id :String = ""
    var items:[item] = []
    
    enum CodingKeys :String ,CodingKey{
        case status
        case totalPrice
        case id = "_id"
        case items
    }
}
struct item:Codable{
    var id:String = ""
    var product_name :String = ""
    var quantity :Int = 1
    var product_price :Int = 0
    
    enum CodingKeys :String , CodingKey{
        case id = "_id"
        case product_name
        case quantity
        case product_price
    }

}
