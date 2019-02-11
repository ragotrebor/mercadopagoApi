//
//  CardIssuerPresenter.swift
//  mercadopagoApi
//
//  Created by Roberto on 2/10/19.
//  Copyright © 2019 Roberto. All rights reserved.
//

// MARK: - Presenter Protocol

protocol CardIssuerPresenterProcotol: AnyObject {
    var view: CardIssuerViewController? {get set}
    var paymentData: PaymentData? {get set}
    var cardIssuers: [CardIssuer]? {get set}
    
    static func createModule(paymentData: PaymentData) -> CardIssuerViewController
    func goToCardInstallments()
    func onViewDidLoad()
    func onCardIssuerSelected(index: Int)
    func onBackButtonTouched()
}

// MARK: - View Protocol

protocol CardIssuerViewProtocol: AnyObject {
    func set(dataSource: [CardIssuer])
    func startActivityIndicator()
    func stopActivityIndicator()
}

class CardIssuerPresenter: CardIssuerPresenterProcotol {
    var view: CardIssuerViewController?
    var paymentData: PaymentData?
    var cardIssuers: [CardIssuer]?
    
    static func createModule(paymentData: PaymentData) -> CardIssuerViewController {
        let viewController = CardIssuerViewController.storyboardNavigationController().topViewController as! CardIssuerViewController
        let presenter: CardIssuerPresenterProcotol = CardIssuerPresenter()
        
        presenter.view = viewController
        presenter.paymentData = paymentData
        viewController.presenter = presenter
        
        return viewController
    }
    
    func goToCardInstallments() {
        guard let paymentData = paymentData else {
            return
        }
        let vc = InstallmentPresenter.createModule(paymentData: paymentData)
        guard let intallmentVc = vc.navigationController else {
            return
        }
        view?.present(intallmentVc, animated: true, completion: nil)
    }
    
    func onViewDidLoad() {
        self.view?.setupNavigationBar(largeTitle: "Emisor de tarjeta")
        self.view?.startActivityIndicator()
        guard let paymentData = paymentData,
            let paymentId = paymentData.paymentId else {
                return
        }
        API.getCardIssuers(paymentId: paymentId,
                            onResponse: {
                                self.view?.stopActivityIndicator()
                            },
                            onSuccess: { (cardIssuers) in
                                let sortedCardIssuers = cardIssuers.sorted(by: {
                                    ($0.name ?? "") < ($1.name ?? "")
                                })
                                self.cardIssuers = sortedCardIssuers
                                self.view?.set(dataSource: sortedCardIssuers)
                            },
                            onFailure: {
                                self.view?.presentAlertView(type: .genericError)
                            })
    }
    
    func onCardIssuerSelected(index: Int) {
        guard let cardIssuers = cardIssuers else {
            return
        }
        
        let cardIssuer = cardIssuers[index]
        
        paymentData?.issuerId = cardIssuer.id
        paymentData?.issuerName = cardIssuer.name
        paymentData?.issuerThumb = cardIssuer.thumbnail
        
        goToCardInstallments()
    }
    
    func onBackButtonTouched() {
        self.view?.dismiss(animated: true, completion: nil)
    }
    
}
