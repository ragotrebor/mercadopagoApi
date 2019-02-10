//
//  AmountViewController.swift
//  mercadopagoApi
//
//  Created by Roberto on 2/10/19.
//  Copyright © 2019 Roberto. All rights reserved.
//

import UIKit

class AmountViewController: HideableKeyboardUIViewController {
    @IBOutlet weak var amountTitleLabel: UILabel! {
        didSet {
            amountTitleLabel.font = .h4Font
            amountTitleLabel.textColor = .primaryFontColor
            amountTitleLabel.textAlignment = .center
            amountTitleLabel.text = "Ingrese Monto"
        }
    }
    
    @IBOutlet weak var amountInputLabel: UILabel! {
        didSet {
            amountInputLabel.font = .body2
            amountInputLabel.textColor = .secondaryFontColor
            amountInputLabel.text = "Monto"
        }
    }
    @IBOutlet weak var amountInputTextField: UITextField! {
        didSet {
            amountInputTextField.clearButtonMode = .whileEditing
            amountInputTextField.keyboardType = .numberPad
            amountInputTextField.returnKeyType = .done
            amountInputTextField.addTarget(
                self,
                action: #selector(onEditingChanged(sender:)),
                for: .editingChanged
            )
        }
    }
    
    @IBOutlet weak var amountInputErrorLabel: UILabel! {
        didSet {
            amountInputErrorLabel.font = .caption
            amountInputErrorLabel.textColor = .errorSalmon
            amountInputErrorLabel.displayText("")
        }
    }
    
    @IBOutlet weak var amountContinueButton: UIButton! {
        didSet {
            amountContinueButton.setTitle("Continuar", for: .normal)
            amountContinueButton.backgroundColor = .secondaryColor
            amountContinueButton.tintColor = .white
            amountContinueButton.layer.cornerRadius = 4
            amountContinueButton.addTarget(
                self, action:
                #selector(onAmountContinueButtonPressed(sender:)),
                for: .touchUpInside
            )
        }
    }
    var presenter: AmountPresenterProcotol?
}

// MARK: - Lifecycle
extension AmountViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.onViewDidLoad()
    }
}

// MARK: - View
extension AmountViewController: AmountViewProtocol {
    func displayAmountInputError(message: String) {
        amountInputErrorLabel.displayText(message)
    }
    
    
}

// MARK: Buttons targets
extension AmountViewController {
    @objc func onAmountContinueButtonPressed(sender: UIButton) {
        guard let amount = amountInputTextField.text else {
            return
        }
        presenter?.onAmountContinueButtonPressed(amount: amount)
    }
}

// MARK: - Textfields targets
extension AmountViewController {
    @objc func onEditingChanged(sender: UITextField) {
        switch sender {
        case amountInputTextField:
            amountInputErrorLabel.displayText("")
        default: break
        }
    }
}
