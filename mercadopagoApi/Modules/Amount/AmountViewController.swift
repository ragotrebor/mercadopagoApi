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
    
    @IBOutlet weak var resumeCardView: UIView! {
        didSet {
            resumeCardView.cornerRadius = 4
            resumeCardView.borderColor = .borderColor
            resumeCardView.borderWidth = 1
        }
    }
    
    @IBOutlet weak var resumeTitleLabel: UILabel! {
        didSet {
            resumeTitleLabel.font = .h6Font
            resumeTitleLabel.textColor = .primaryFontColor
            resumeTitleLabel.text = "Resumen de pago"
        }
    }
    
    @IBOutlet weak var cardPaymentMethodLabel: UILabel! {
        didSet {
            cardPaymentMethodLabel.font = .body2
            cardPaymentMethodLabel.textColor = .primaryFontColor
            cardPaymentMethodLabel.text = ""
            cardPaymentMethodLabel.numberOfLines = 0
        }
    }
    
    @IBOutlet weak var cardIssuerLabel: UILabel! {
        didSet {
            cardIssuerLabel.font = .body2
            cardIssuerLabel.textColor = .primaryFontColor
            cardIssuerLabel.text = ""
            cardIssuerLabel.numberOfLines = 0
        }
    }
    @IBOutlet weak var cardInstallmentMessageLabel: UILabel! {
        didSet {
            cardInstallmentMessageLabel.font = .body2
            cardInstallmentMessageLabel.textColor = .primaryFontColor
            cardInstallmentMessageLabel.text = ""
            cardInstallmentMessageLabel.numberOfLines = 0
        }
    }
    @IBOutlet weak var cardInstallmentTotalLabel: UILabel!  {
        didSet {
            cardInstallmentTotalLabel.font = .body2
            cardInstallmentTotalLabel.textColor = .primaryFontColor
            cardInstallmentTotalLabel.text = ""
            cardInstallmentTotalLabel.numberOfLines = 0
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
    func displayResumeCard(paymentData: PaymentData) {
        resumeCardView.isHidden = false
        amountInputTextField.text = paymentData.amount
        cardPaymentMethodLabel.text = paymentData.paymentName
        cardIssuerLabel.text = paymentData.issuerName
        cardInstallmentMessageLabel.text = paymentData.installmentMessage
        cardInstallmentTotalLabel.text = "Total: \(paymentData.installmentTotal)"
    }
    
    func hideResumeCard() {
        resumeCardView.isHidden = true
    }
    
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
