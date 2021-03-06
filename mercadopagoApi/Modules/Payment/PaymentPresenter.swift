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
    var payments: [Payment]? {get set}
    
    static func createModule(paymentData: PaymentData) -> PaymentViewController
    func goToCardIssuer()
    func onViewDidLoad()
    func onPaymentMethodSelected(index: Int)
    func onBackButtonTouched()
}

// MARK: - View Protocol

protocol PaymentViewProtocol: AnyObject {
    func set(dataSource: [Payment])
    func startActivityIndicator()
    func stopActivityIndicator()
}

class PaymentPresenter: PaymentPresenterProcotol {
    var view: PaymentViewController?
    var paymentData: PaymentData?
    var payments: [Payment]?
    
    static func createModule(paymentData: PaymentData) -> PaymentViewController {
        let viewController = PaymentViewController.storyboardNavigationController().topViewController as! PaymentViewController
        let presenter: PaymentPresenterProcotol = PaymentPresenter()
        
        presenter.paymentData = paymentData
        presenter.view = viewController
        viewController.presenter = presenter
        
        return viewController
    }
    
    func goToCardIssuer() {
        guard let paymentData = paymentData else {
            return
        }
        let vc = CardIssuerPresenter.createModule(paymentData: paymentData)
        guard let cardIssuerVc = vc.navigationController else {
            return
        }
        view?.present(cardIssuerVc, animated: true, completion: nil)
    }
    
    func onPaymentMethodSelected(index: Int) {
        guard let payments = payments else {
            return
        }

        let payment = payments[index]
        
        paymentData?.paymentId = payment.id
        paymentData?.paymentName = payment.name
        paymentData?.paymentThumb = payment.thumbnail
        
        goToCardIssuer()
    }
    
    func onViewDidLoad() {
        self.view?.setupNavigationBar(largeTitle: "Método de pago")
        self.view?.startActivityIndicator()
        API.getPayments(onResponse: {
                            self.view?.stopActivityIndicator()
                        },
                        onSuccess: { (payments) in
                            let sortedPayments = payments.sorted(by: {
                                ($0.name ?? "") < ($1.name ?? "")
                            })
                            self.payments = sortedPayments
                            self.view?.set(dataSource: sortedPayments)
                        },
                        onFailure: {
                            self.view?.presentAlertView(type: .genericError)
                        })
    }
    
    func onBackButtonTouched() {
        self.view?.dismiss(animated: true, completion: nil)
    }
}
