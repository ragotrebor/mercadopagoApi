//
//  PaymentPresenter.swift
//  mercadopagoApi
//
//  Created by Roberto on 2/10/19.
//  Copyright © 2019 Roberto. All rights reserved.
//

import Foundation

// MARK: - Presenter Protocol

protocol PaymentPresenterProcotol: AnyObject {
    var view: PaymentViewController? {get set}
    var paymentData: PaymentData? {get set}
    
    static func createModule() -> PaymentViewController
    func goToCardIssuer()
    func onPaymentMethodSelected(paymentId: String)
}

// MARK: - View Protocol

protocol PaymentViewProtocol: AnyObject {
    func startActivityIndicator()
    func stopActivityIndicator()
    func reloadPaymentTable()
}

class PaymentPresenter: PaymentPresenterProcotol {
    var view: PaymentViewController?
    
    var paymentData: PaymentData?
    
    static func createModule() -> PaymentViewController {
        let viewController = PaymentViewController.storyboardNavigationController().topViewController as! PaymentViewController
        let presenter: PaymentPresenterProcotol = PaymentPresenter()
        
        presenter.view = viewController
        presenter.paymentData = PaymentData()
        viewController.presenter = presenter
        
        return viewController
    }
    
    func goToCardIssuer() {
        
    }
    
    func onPaymentMethodSelected(paymentId: String) {
        
    }
    
    
}
