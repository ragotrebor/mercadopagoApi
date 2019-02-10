//
//  API.swift
//  mercadopagoApi
//
//  Created by Roberto on 2/9/19.
//  Copyright © 2019 Roberto. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper
import ObjectMapper

struct PaymentsParamaters: Parameterizable {
    var asParameters: Parameters {
        return [
            "public_key": API.publicKey
        ]
    }
}

// MARK : - API Vars
enum API {
    static let publicKey = "444a9ef5-8a6b-429f-abdf-587639155d88"
    static let baseUrl = "https://api.mercadopago.com/v1/payment_methods"
    static let paymentUrl = ""
}

// MARK: - API Methods

extension API {
    static func getPayments() {
        let parameters = PaymentsParamaters().asParameters
        Alamofire.request(baseUrl, method: .get, parameters: parameters ).responseArray { (response: DataResponse<[Payment]>) in
            
            let payments = response.result.value
            print(payments.debugDescription)
        }
    }
    
    static func getCardIssuers(paymentId: String) {
        Alamofire.request("https://eee.com/geo?lat=10.2&lng=10.2").responseObject { (response: DataResponse<CardIssuer>) in

            let cardIssuers = response.result.value
            print(cardIssuers)
        }
    }
    
    static func getInstallments(amount: String, paymentId: String, issuerId: String) {
        Alamofire.request("https://eee.com/geo?lat=10.2&lng=10.2").responseObject { (response: DataResponse<Installment>) in
            
            let installments = response.result.value
            print(installments)
        }
    }
}
