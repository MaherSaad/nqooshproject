//
//  ServicesModel.swift
//  nqosh
//
//  Created by Mac on 1/26/19.
//  Copyright © 2019 Hesham. All rights reserved.
//

import Foundation
import SwiftyJSON

public class ServicesModel:NSObject {
    
    let id : Int?
    let name : String?
    let desc : String?
    let image : String?

    init?(dic:[String:JSON]) {
        guard let id = dic["id"]?.int ,let name = dic["name"]?.string ,let image = dic["image"]?.toImagePath, let description = dic["description"]?.string   else {
            return nil
        }
        self.id = id
        self.name = name
        self.image = image
        self.desc = description
    }
}
