//
//  Order.swift
//  QskipperAdmin
//
//  Created by Batch-1 on 24/05/24.
//

import Foundation

struct Order {
    var Restaurant_id: String
    var status:Status
    var price: Double
    var items: [(name: String, quantity: Int)]
    var prepTimeRemaining: Int
    var bookingTime: Date
    var rating: Double?
    var userName:String
}

struct Status{
    var id :Int
    var currentStatus:String
    
    static var currentStat:[Status]{
        return [
            Status(id: 0, currentStatus: "Placed"),
            Status(id: 1, currentStatus: "Preparing"),
            Status(id: 2, currentStatus: "Prepared"),
            Status(id: 3, currentStatus: "Picked Up")
        ]
    }
    
}
