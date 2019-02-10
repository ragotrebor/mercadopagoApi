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
    
    static func createModule() -> CardIssuerViewController
    func goToCardInstallments()
    func onViewDidLoad()
    func onCardIssuerSelected(index: Int)
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
    
    static func createModule() -> CardIssuerViewController {
        let viewController = CardIssuerViewController.storyboardViewController()
        let presenter: CardIssuerPresenterProcotol = CardIssuerPresenter()
        
        presenter.view = viewController
        viewController.presenter = presenter
        
        return viewController
    }
    
    func goToCardInstallments() {
        
    }
    
    func onViewDidLoad() {
        self.view?.startActivityIndicator()
        let paymentId = "visa"
        API.getCardIssuers(paymentId: paymentId,
        onResponse: {
            self.view?.stopActivityIndicator()
        }, onSuccess: { (cardIssuers) in
            let sortedCardIssuers = cardIssuers.sorted(by: {
                ($0.name ?? "") < ($1.name ?? "")
            })
            self.cardIssuers = cardIssuers
            self.view?.set(dataSource: cardIssuers)
        }, onFailure: {
            self.view?.presentAlertView(type: .genericError)
        })
    }
    
    func onCardIssuerSelected(index: Int) {
        
    }
    
    
}
