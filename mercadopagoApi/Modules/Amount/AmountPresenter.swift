//
//  AmountPresenter.swift
//  mercadopagoApi
//
//  Created by Roberto on 2/10/19.
//  Copyright © 2019 Roberto. All rights reserved.
//

import Foundation

struct PaymentData {
    var amount: String?
    var paymentId: String?
    var paymentName: String?
    var paymentThumb: String?
    var issuerId: String?
    var issuerName: String?
    var issuerThumb: String?
}

// MARK: - Presenter Protocol

protocol AmountPresenterProcotol: AnyObject {
    var view: AmountViewController? {get set}
    var paymentData: PaymentData? {get set}
    
    static func createModule() -> AmountViewController
    func goToPayment()
    func onAmountContinueButtonPressed(amount: String)
}

// MARK: - View Protocol

protocol AmountViewProtocol: AnyObject {
    func displayAmountInputError(message: String)
}

// MARK: - Presenter

class AmountPresenter: AmountPresenterProcotol {
    var view: AmountViewController?
    
    var paymentData: PaymentData?
    
    static func createModule() -> AmountViewController {
        let viewController = AmountViewController.storyboardViewController()
        let presenter: AmountPresenterProcotol = AmountPresenter()
        
        presenter.view = viewController
        presenter.paymentData = PaymentData()
        viewController.presenter = presenter
        
        return viewController
    }
    
    func goToPayment() {
        let paymentVc = PaymentPresenter.createModule()
        paymentVc.presenter?.paymentData = paymentData
        view?.present(paymentVc, animated: true, completion: nil)
        
    }
    
    func onAmountContinueButtonPressed(amount: String) {
        guard !amount.isEmpty else {
            view?.displayAmountInputError(message: "El monto no debe ser vacio")
            return
        }
        guard let intAmount = Int(amount),
            intAmount >= 0 else {
            view?.displayAmountInputError(message: "El monto debe ser superior a 0")
            return
        }
        paymentData?.amount = amount
        goToPayment()
    }
    
    
}
