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

//MARK: - Parameters
struct PaymentsParamaters: Parameterizable {
    var asParameters: Parameters {
        return [
            "public_key": API.publicKey
        ]
    }
}

struct CardIssuerParamaters: Parameterizable {
    var paymentId: String?
    
    var asParameters: Parameters {
        guard let paymentId = paymentId else {
            return [:]
        }
        return [
            "payment_method_id": paymentId,
            "public_key": API.publicKey
        ]
    }
}

// MARK : - API Vars
enum API {
    static let publicKey = "444a9ef5-8a6b-429f-abdf-587639155d88"
    static let baseUrl = "https://api.mercadopago.com/v1/payment_methods"
    static let cardIssuersUrl = "\(baseUrl)/card_issuers"
    static let installmentUrl = "\(baseUrl)/installments"
}

// MARK: - API Methods

extension API {
    static func getPayments(onResponse: CompletionHandler = nil, onSuccess: SuccessHandler<[Payment]> = nil, onFailure: CompletionHandler = nil) {
        let parameters = PaymentsParamaters().asParameters
        Alamofire.request(baseUrl, method: .get, parameters: parameters ).responseArray { (response: DataResponse<[Payment]>) in
            
            if let onResponse = onResponse {
                onResponse()
            }
            
            switch response.result {
            case .success(let value):
                guard let onSuccess = onSuccess else {
                    return
                }
                
                onSuccess(value)
            case .failure:
                guard let onFailure = onFailure else {
                    return
                }
                
                onFailure()
                
            }
        }
    }
    
    static func getCardIssuers(paymentId: String, onResponse: CompletionHandler = nil, onSuccess: SuccessHandler<[CardIssuer]> = nil, onFailure: CompletionHandler = nil) {
        let parameters = CardIssuerParamaters(paymentId: paymentId).asParameters
        Alamofire.request(cardIssuersUrl, method: .get, parameters: parameters ).responseArray  { (response: DataResponse<[CardIssuer]>) in

            if let onResponse = onResponse {
                onResponse()
            }
            
            switch response.result {
            case .success(let value):
                guard let onSuccess = onSuccess else {
                    return
                }
                
                onSuccess(value)
            case .failure:
                guard let onFailure = onFailure else {
                    return
                }
                
                onFailure()
                
            }
        }
    }
    
    static func getInstallments(amount: String, paymentId: String, issuerId: String) {
        Alamofire.request("https://eee.com/geo?lat=10.2&lng=10.2").responseObject { (response: DataResponse<Installment>) in
            
            let installments = response.result.value
            print(installments)
        }
    }
}
