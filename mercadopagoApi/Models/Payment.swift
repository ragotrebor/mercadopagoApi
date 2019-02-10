//
//  Payment.swift
//  mercadopagoApi
//
//  Created by Roberto on 2/9/19.
//  Copyright © 2019 Roberto. All rights reserved.
//

import ObjectMapper

class Payment: Mappable {
    var id: String?
    var name: String?
    var status: String?
    var thumbnail: String?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        status <- map["status"]
        thumbnail <- map["secure_thumbnail"]
    }
}
