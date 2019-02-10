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
    
    static func createModule() -> InstallmentViewController
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
    
    static func createModule() -> InstallmentViewController {
        let viewController = InstallmentViewController.storyboardNavigationController().topViewController as! InstallmentViewController
        let presenter: InstallmentPresenterProcotol = InstallmentPresenter()
        
        presenter.view = viewController
        viewController.presenter = presenter
        
        return viewController
    }
    
    func returnToAmount() {
        let vc = AmountPresenter.createModule()
        guard let intallmentVc = vc.navigationController else {
            return
        }
        intallmentVc.hero.modalAnimationType = .pull(direction: .right)
        view?.present(intallmentVc, animated: true, completion: nil)
    }
    
    func onViewDidLoad() {
        self.view?.setupNavigationBar(largeTitle: "Selección de cuotas")
        self.view?.startActivityIndicator()
        let paymentId = "visa"
        let amount = "20000"
        let issuerId = "288"
        API.getInstallments(amount: amount,
                            paymentId: paymentId,
                            issuerId: issuerId,
                            onResponse: {
                                self.view?.stopActivityIndicator()
                            }, onSuccess: { (installments) in
                                guard let installment = installments.first,
                                    let payerCosts = installment.payerCosts else {
                                    return
                                }
                                self.installments = payerCosts
                                self.view?.set(dataSource: payerCosts)
                            }, onFailure: {
                                self.view?.presentAlertView(type: .genericError)
                            })
    }
    
    func onInstallmentSelected(index: Int) {
        returnToAmount()
    }
    
    func onBackButtonTouched() {
        self.view?.dismiss(animated: true, completion: nil)
    }
}
