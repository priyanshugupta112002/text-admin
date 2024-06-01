//
//  DataController.swift
//  QskipperAdmin
//
//  Created by Batch-1 on 31/05/24.
//

import Foundation
import UIKit

class DataControlller{
    
     static var shared = DataControlller()
    
    
    
    private var _currentUser = user()
    
    private var _restaurant = Restaurant()
    
    private var _product = Product()
    
    
    var Currentuser : user{
        return _currentUser
    }
    func setID( id:String){
        _currentUser.id = id
    }
    
  
    
    var restaurant :Restaurant {
        return _restaurant
    }
    
    func setEstimatedTime(time:Int){
        _restaurant.estimatedTime = time
    }
    func set_restaurant(name:String){
        _restaurant.restaurant_Name = name
    }
    func set_restaurant_banner (image:UIImage){
        _restaurant.banner_photo = image
    }
    func set_restaurant_cuisine(cuisine:String){
        _restaurant.cuisine = cuisine
    }
    
    
    
    var product:Product{
        return _product
    }
    
    var allProduct: [Product] = []
    
    func set_product_name(name:String){
        _product.product_name = name
    }
    func set_product_price(price:Int){
        _product.product_price = price
    }
    func set_product_image(image:UIImage){
        _product.product_photo = image
    }
    func set_prepTime(time:Double){
        _product.extraTime = time
    }
    func set_product_category (category:String){
        _product.food_category = category
    }
    func set_product_description(description :String){
        _product.description = description
    }
    
    
    
    
    
}
