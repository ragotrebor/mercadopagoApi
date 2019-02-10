//
//  SplashScreenPresenter.swift
//  mercadopagoApi
//
//  Created by Roberto on 2/9/19.
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

protocol SplashScreenPresenterProtocol: AnyObject {
    var view: SplashScreenViewController? {get set}
    var paymentData: PaymentData? {get set}
    
    static func createModule() -> SplashScreenViewController
    func onViewDidLoad()
    func goToPayments()
    func presentAlertView(with errorMessage: String)
    
}

// MARK: - View Protocol

protocol SplashScreenViewProtocol: AnyObject {}

// MARK: - Presenter
class SplashScreenPresenter: SplashScreenPresenterProtocol {
    var paymentData: PaymentData?
    
    var view: SplashScreenViewController?
    
    static func createModule() -> SplashScreenViewController {
        let viewController = SplashScreenViewController.storyboardViewController()
        let presenter: SplashScreenPresenterProtocol = SplashScreenPresenter()
        
        presenter.view = viewController
        presenter.paymentData = PaymentData()
        viewController.presenter = presenter
        
        return viewController
    }
    
    func onViewDidLoad() {
        API.getPayments()
    }
    
    func goToPayments() {
        
    }
    
    func presentAlertView(with errorMessage: String) {
        view?.presentAlertView(type: .genericError)
    }
    
    
}
