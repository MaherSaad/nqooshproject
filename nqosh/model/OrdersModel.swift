//
//  OrdersModel.swift
//  nqosh
//
//  Created by Mac on 1/30/19.
//  Copyright © 2019 Hesham. All rights reserved.
//

import Foundation
import SwiftyJSON

public class OrdersModel:NSObject {

   
  
let id : Int?
let total : String?
let client_name : String?
let client_phone : String?
let longitude : String?
let latitude : String?
let plus : String?
var products = [JSON]()
    
init?(dic:[String:JSON]) {
    guard let id = dic["id"]?.int ,let total = dic["total"]?.string,
    let client_name = dic["client_name"]?.string ,let client_phone = dic["client_phone"]?.string,
    let longitude = dic["longitude"]?.string ,let latitude = dic["latitude"]?.string, let plus = dic["plus"]?.string else {
        return nil
    }
    self.id = id
    self.total = total
    self.client_name = client_name
    self.client_phone = client_phone
    self.longitude = longitude
    self.latitude = latitude
    self.plus = plus
    self.products = (dic["products"]?.array)!
}
}
