//
//  Extensions.swift
//  mercadopagoApi
//
//  Created by Roberto on 2/9/19.
//  Copyright © 2019 Roberto. All rights reserved.
//

import UIKit
import Alamofire

// MARK: - UIColor

extension UIColor {
    static let primaryColor = UIColor(red:1.00, green:0.95, blue:0.35, alpha:1.0)
    static let secondaryColor = UIColor(red:0.20, green:0.51, blue:0.98, alpha:1.0)
    static let primaryFontColor = UIColor(red:0.20, green:0.20, blue:0.20, alpha:1.0)
    static let secondadyFontColor = UIColor(red:0.60, green:0.60, blue:0.60, alpha:1.0)
    static let sucessGreen = UIColor(red:0.22, green:0.71, blue:0.29, alpha:1.0)
    static let errorSalmon = UIColor(red: 1.0, green: 107.0 / 255.0, blue: 107.0 / 255.0, alpha: 1.0)
}

// MARK: - Typealias

typealias CompletionHandler = (()->Void)?

extension String {
    static let empty = ""
    
    static let defaultAcceptActionTitle = "Aceptar"
    static let defaultAlertTitle = "Atención"
    static let defaultAlertMessage = "Ha ocurrido un error, vuelta a intentar más tarde"
    static let cancel = "Cancelar"
    static let ok = "OK"
}

// MARK: - ViewController

extension UIViewController {
    
    enum AlertViewTypes {
        case emptyAlert
        case genericError
        case customAlert(title: String, message: String)
        case customMessage(message: String)
    }
    
    func presentAlertView(type: AlertViewTypes, acceptAction: ((UIAlertAction) -> Void)? = nil, cancelAction: ((UIAlertAction) -> Void)? = nil) {
        
        var alertTitle: String = .defaultAlertTitle
        var alertMessage: String = .empty
        
        switch (type) {
        case .genericError:
            alertMessage = .defaultAlertMessage
        case .customMessage(let message):
            alertMessage = message
        case .emptyAlert:
            break
        case .customAlert(let title, let message):
            alertTitle = title
            alertMessage = message
        }
        
        let alertController = UIAlertController(
            title: alertTitle,
            message: alertMessage,
            preferredStyle: .alert
        )
        
        alertController.addAction(
            UIAlertAction(
                title: .defaultAcceptActionTitle,
                style: .default,
                handler: acceptAction
            )
        )
        
        if let cancelAction = cancelAction {
            alertController.addAction(
                UIAlertAction(
                    title: .cancel,
                    style: .cancel,
                    handler: cancelAction
                )
            )
        }
        
        applyDefaultAlertStyle(
            alertController: alertController,
            alertTitle: alertTitle,
            alertMessage: alertMessage
        )
        
        self.present(
            alertController,
            animated: true
        )
    }
    
    func applyDefaultAlertStyle(alertController: UIAlertController, alertTitle: String, alertMessage: String) {
        
        alertController.view.tintColor = .secondaryColor
        
        let attributedTitle = NSMutableAttributedString(
            string: alertTitle,
            attributes: [
                .font: UIFont(name: "Montserrat-Bold", size: 17.0)!,
                .foregroundColor: UIColor(white: 33.0 / 255.0, alpha: 1.0)
            ]
        )
        
        let attributedMessage = NSMutableAttributedString(
            string: alertMessage,
            attributes: [
                .font: UIFont(name: "Montserrat-Regular", size: 13.0)!,
                .foregroundColor: UIColor(white: 33.0 / 255.0, alpha: 1.0)
            ]
        )
        
        alertController.setValue(
            attributedTitle,
            forKey: "attributedTitle"
        )
        
        alertController.setValue(
            attributedMessage,
            forKey: "attributedMessage"
        )
    }
}

// MARK: - Storyboardable
protocol Storyboardable: class {
    static var defaultStoryboardName: String { get }
}

extension Storyboardable where Self: UIViewController {
    static var defaultStoryboardName: String {
        let selfName = String(describing: self)
        return selfName.replacingOccurrences(of: "ViewController", with: "")
    }
    
    static func storyboardViewController() -> Self {
        let storyboard = UIStoryboard(name: defaultStoryboardName, bundle: nil)
        
        guard let vc = storyboard.instantiateInitialViewController() as? Self else {
            fatalError("Could not instantiate initial storyboard with name: \(defaultStoryboardName)")
        }
        
        return vc
    }
}

extension UIViewController: Storyboardable { }

// MARK: - Parameterizable
protocol Parameterizable {
    var asParameters: Parameters {get}
}
