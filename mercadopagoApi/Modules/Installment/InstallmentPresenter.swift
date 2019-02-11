//
//  InstallmentPresenter.swift
//  mercadopagoApi
//
//  Created by Roberto on 2/10/19.
//  Copyright © 2019 Roberto. All rights reserved.
//

// MARK: - Presenter Protocol

protocol InstallmentPresenterProcotol: AnyObject {
    var view: InstallmentViewController? {get set}
    var paymentData: PaymentData? {get set}
    var installments: [PayerCost]? {get set}
    
    static func createModule(paymentData: PaymentData) -> InstallmentViewController
    func returnToAmount()
    func onViewDidLoad()
    func onInstallmentSelected(index: Int)
    func onBackButtonTouched()
}

// MARK: - View Protocol

protocol InstallmentViewProtocol: AnyObject {
    func set(dataSource: [PayerCost])
    func startActivityIndicator()
    func stopActivityIndicator()
}

class InstallmentPresenter: InstallmentPresenterProcotol {
    var view: InstallmentViewController?
    var paymentData: PaymentData?
    var installments: [PayerCost]?
    
    static func createModule(paymentData: PaymentData) -> InstallmentViewController {
        let viewController = InstallmentViewController.storyboardNavigationController().topViewController as! InstallmentViewController
        let presenter: InstallmentPresenterProcotol = InstallmentPresenter()
        
        presenter.view = viewController
        presenter.paymentData = paymentData
        viewController.presenter = presenter
        
        return viewController
    }
    
    func returnToAmount() {
        guard let paymentData = paymentData else {
            return
        }
        let vc = AmountPresenter.createModule(paymentData: paymentData)
        guard let intallmentVc = vc.navigationController else {
            return
        }
        intallmentVc.hero.modalAnimationType = .pull(direction: .right)
        view?.present(intallmentVc, animated: true, completion: nil)
    }
    
    func onViewDidLoad() {
        self.view?.setupNavigationBar(largeTitle: "Selección de cuotas")
        self.view?.startActivityIndicator()
        
        guard let paymentData = paymentData,
            let paymentId = paymentData.paymentId,
            let issuerId = paymentData.issuerId,
            let amount = paymentData.amount else {
                return
        }
        
        API.getInstallments(amount: amount,
                            paymentId: paymentId,
                            issuerId: issuerId,
                            onResponse: {
                                self.view?.stopActivityIndicator()
                            }, onSuccess: { (installments) in
                                guard let installment = installments.first,
                                    let payerCosts = installment.payerCosts else {
                                    self.view?.set(dataSource: [PayerCost]())
                                    return
                                }
                                self.installments = payerCosts
                                self.view?.set(dataSource: payerCosts)
                            }, onFailure: {
                                self.view?.presentAlertView(type: .genericError)
                            })
    }
    
    func onInstallmentSelected(index: Int) {
        guard let installments = installments else {
            return
        }
        
        let installment = installments[index]
        
        paymentData?.installmentMessage = installment.recommendedMessage
        paymentData?.installmentTotal = String(installment.totalAmount ?? 0)
        returnToAmount()
    }
    
    func onBackButtonTouched() {
        self.view?.dismiss(animated: true, completion: nil)
    }
}
