//
//  user.swift
//  QskipperAdmin
//
//  Created by Batch-1 on 28/05/24.
//

import Foundation


struct user: Codable  {
    var id :String = ""
    var email: String = ""
    var password: String = ""
    var securityCode: String = ""
}


struct User:Codable{
    
    var id:String = ""
    enum CodingKeys :String ,CodingKey{
        case id
    }
}

