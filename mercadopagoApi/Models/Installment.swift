//
//  Installment.swift
//  mercadopagoApi
//
//  Created by Roberto on 2/9/19.
//  Copyright © 2019 Roberto. All rights reserved.
//

import ObjectMapper

class Installment: Mappable {
    var paymentId: String?
    var issuerId: String?
    var payerCosts: [PayerCost]?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        paymentId <- map["payment_method_id"]
        issuerId <- map["issuer.id"]
        payerCosts <- map["payer_costs"]
    }
}

class PayerCost: Mappable {
    var installments: String?
    var recommendedMessage: String?
    var totalAmount: Int?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        installments <- map["installments"]
        recommendedMessage <- map["recommended_message"]
        totalAmount <- map["total_amount"]
    }
}
