//
//  Extensions.swift
//  mercadopagoApi
//
//  Created by Roberto on 2/9/19.
//  Copyright © 2019 Roberto. All rights reserved.
//

import UIKit
import Alamofire
import Hero

// MARK: - UIFont

enum AppFontSizes: CGFloat {
    case h1Size = 92.38
    case h2Size = 57.74
    case h3Size = 46.19
    case h4Size = 32.72
    case h5Size = 23.1
    case h6Size = 19.25
    case body1 = 15.4
    case body2 = 13.47
    case caption = 11.55
    case tabItem = 10
}

enum AppFontTypes: String {
    case medium = "Montserrat-Medium"
    case regular = "Montserrat-Regular"
}

extension UIFont {
    static let h4Font = UIFont(name: AppFontTypes.regular.rawValue, size: AppFontSizes.h4Size.rawValue)!
    static let h5Font = UIFont(name: AppFontTypes.regular.rawValue, size: AppFontSizes.h5Size.rawValue)!
    static let h6Font = UIFont(name: AppFontTypes.regular.rawValue, size: AppFontSizes.h6Size.rawValue)!
    static let body1 = UIFont(name: AppFontTypes.regular.rawValue, size: AppFontSizes.body1.rawValue)!
    static let body2 = UIFont(name: AppFontTypes.regular.rawValue, size: AppFontSizes.body2.rawValue)!
    static let subtitle1 = UIFont(name: AppFontTypes.regular.rawValue, size: AppFontSizes.body1.rawValue)!
    static let subtitle2 = UIFont(name: AppFontTypes.regular.rawValue, size: AppFontSizes.body2.rawValue)!
    static let button = UIFont(name: AppFontTypes.medium.rawValue, size: AppFontSizes.body2.rawValue)!
    static let caption = UIFont(name: AppFontTypes.regular.rawValue, size: AppFontSizes.caption.rawValue)!
}

// MARK: - UIColor

extension UIColor {
    static let primaryColor = UIColor(red:1.00, green:0.95, blue:0.35, alpha:1.0)
    static let secondaryColor = UIColor(red:0.20, green:0.51, blue:0.98, alpha:1.0)
    static let primaryFontColor = UIColor(red:0.20, green:0.20, blue:0.20, alpha:1.0)
    static let secondaryFontColor = UIColor(red:0.60, green:0.60, blue:0.60, alpha:1.0)
    static let sucessGreen = UIColor(red:0.22, green:0.71, blue:0.29, alpha:1.0)
    static let errorSalmon = UIColor(red: 1.0, green: 107.0 / 255.0, blue: 107.0 / 255.0, alpha: 1.0)
    static let borderColor = UIColor(white: 0.0, alpha: 0.12)
}

// MARK: - Typealias

typealias CompletionHandler = (()->Void)?
typealias SuccessHandler<T> = ((T)-> Void)?

// MARK: - String

extension String {
    static let empty = ""
    
    static let defaultAcceptActionTitle = "Aceptar"
    static let defaultAlertTitle = "Atención"
    static let defaultAlertMessage = "Ha ocurrido un error, vuelta a intentar más tarde"
    static let cancel = "Cancelar"
    static let ok = "OK"
    static let emptyPayments = "No se encontraron métodos de pago"
    static let emptyCardIssuers = "No se encontraron emisores de la tarjeta seleccionada"
    static let emptyInstallments = "No se encontraron cuotas para el monto seleccionado"
}

// MARK: - ViewController

extension UIViewController {
    
    enum NavigationBarColors {
        case empty
        case blue
    }
    
    enum NavigationBarLeftButtonImage: String {
        case back = "navBackArrow"
    }
    
    func setupNavigationBar(navigationBarColor: NavigationBarColors = .blue, navigationBarLeftButtonImage: NavigationBarLeftButtonImage = .back, largeTitle: String? = nil) {
        
        guard let navigationController = self.navigationController else {
            return
        }
        
        let navigationBar = navigationController.navigationBar
        
        navigationBar.isTranslucent = false
        navigationBar.shadowImage = UIImage()
        
        var barTintColor: UIColor?
        
        switch navigationBarColor {
        case .empty:
            navigationBar.setBackgroundImage(UIImage(), for: .default)
            navigationBar.shadowImage = UIImage()
            navigationBar.isTranslucent = true
        case .blue:
            barTintColor = UIColor.white
            let leftImageName = navigationBarLeftButtonImage.rawValue
            self.navigationItem.leftBarButtonItem?.image = UIImage(named: leftImageName)?.withRenderingMode(.alwaysTemplate)
            
            self.navigationItem.leftBarButtonItem?.tintColor = .secondaryColor
        }
        navigationBar.barTintColor = barTintColor
        
        if let largeTitle = largeTitle {
            navigationBar.prefersLargeTitles = true
            navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.primaryFontColor, NSAttributedString.Key.font: UIFont.h5Font]
            self.navigationItem.largeTitleDisplayMode = .automatic
            self.navigationItem.title = largeTitle
            navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.primaryFontColor, NSAttributedString.Key.font: UIFont.body1]
        }
        
    }
    
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
                .font: UIFont.body1,
                .foregroundColor: UIColor(white: 33.0 / 255.0, alpha: 1.0)
            ]
        )
        
        let attributedMessage = NSMutableAttributedString(
            string: alertMessage,
            attributes: [
                .font: UIFont.body2,
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
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
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
    
    static func storyboardNavigationController() -> UINavigationController {
        let nc = UINavigationController(rootViewController: storyboardViewController())
        nc.hero.isEnabled = true
        nc.hero.modalAnimationType = .autoReverse(presenting: .push(direction: .left))
        return nc
    }
}

extension UIViewController: Storyboardable { }

// MARK: - Parameterizable
protocol Parameterizable {
    var asParameters: Parameters {get}
}


// MARK: - Class HideableKeyboardUIViewController
class HideableKeyboardUIViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
}

// MARK: - UILabel

extension UILabel {
    func displayText(_ text: String) {
        if text.isEmpty {
            self.text = text
            self.isHidden = true
        } else {
            self.text = text
            self.isHidden = false
        }
        
    }
}

// MARK: - UIView

extension UIView {
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
}

// MARK: - UIBarButtonItem

extension UIBarButtonItem {
    func addTargetForAction(target: AnyObject, action: Selector) {
        self.target = target
        self.action = action
    }
}

// MARK: - UITableView

extension UITableView {
    
    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width * 0.75, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .secondaryFontColor
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = .body1
        messageLabel.sizeToFit()
        
        self.backgroundView = messageLabel
    }
    
    func restore() {
        self.backgroundView = nil
    }
}
