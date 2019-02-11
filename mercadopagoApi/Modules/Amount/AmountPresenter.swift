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
    var installmentMessage: String?
    var installmentTotal: String?
}

// MARK: - Presenter Protocol

protocol AmountPresenterProcotol: AnyObject {
    var view: AmountViewController? {get set}
    var paymentData: PaymentData? {get set}
    
    static func createModule(paymentData: PaymentData) -> AmountViewController
    func goToPayment()
    func onAmountContinueButtonPressed(amount: String)
    func onViewDidLoad()
}

// MARK: - View Protocol

protocol AmountViewProtocol: AnyObject {
    func displayResumeCard(paymentData: PaymentData)
    func hideResumeCard()
    func displayAmountInputError(message: String)
}

// MARK: - Presenter

class AmountPresenter: AmountPresenterProcotol {
    var view: AmountViewController?
    
    var paymentData: PaymentData?
    
    static func createModule(paymentData: PaymentData) -> AmountViewController {
        let viewController = AmountViewController.storyboardNavigationController().topViewController as! AmountViewController
        let presenter: AmountPresenterProcotol = AmountPresenter()
        
        presenter.view = viewController
        presenter.paymentData = paymentData
        viewController.presenter = presenter
        
        return viewController
    }
    
    func goToPayment() {
        guard let paymentData = paymentData else {
            return
        }
        let vc = PaymentPresenter.createModule(paymentData: paymentData)
        guard let paymentVc = vc.navigationController else {
            return
        }
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
    func onViewDidLoad() {
        if let paymentData = paymentData,
            let installmentMessage = paymentData.installmentMessage,
            !installmentMessage.isEmpty {
            self.view?.displayResumeCard(paymentData: paymentData)
        } else {
            self.view?.hideResumeCard()
        }
            
        self.view?.setupNavigationBar(navigationBarColor: .empty)
    }
    
}
