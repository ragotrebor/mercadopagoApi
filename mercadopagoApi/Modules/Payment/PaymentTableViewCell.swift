//
//  PaymentTableViewCell.swift
//  mercadopagoApi
//
//  Created by Roberto on 2/10/19.
//  Copyright © 2019 Roberto. All rights reserved.
//

import UIKit
import Kingfisher

class PaymentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var borderView: UIView! {
        didSet {
            borderView.cornerRadius = 4
            borderView.borderColor = .borderColor
            borderView.borderWidth = 1
        }
    }
    
    @IBOutlet weak var paymentImageView: UIImageView! {
        didSet {
            paymentImageView.backgroundColor = .borderColor
            paymentImageView.contentMode = .scaleAspectFit
        }
    }
    @IBOutlet weak var paymentNameLabel: UILabel! {
        didSet {
            paymentNameLabel.text = ""
            paymentNameLabel.textColor = .primaryFontColor
            paymentNameLabel.font = .body1
        }
    }
    
    @IBOutlet weak var paymentStatusLabel: UILabel! {
        didSet {
            paymentStatusLabel.text = ""
            paymentStatusLabel.isHidden = true
            paymentStatusLabel.textColor = .primaryFontColor
            paymentStatusLabel.font = .body1
        }
    }
    
    var paymentData: Payment? {
        didSet {
            configureCell()
        }
    }

}

// MARK: - LifeCycle
extension PaymentTableViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

// MARK: - Methods
extension PaymentTableViewCell {
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func configureCell() {
        guard let payment = paymentData else {
            return
        }
        paymentNameLabel.text = payment.name
        if let urlString = payment.thumbnail {
            paymentImageView.kf.setImage(with: URL(string:urlString))
        }
        
        switch payment.status {
        case "active":
            borderView.backgroundColor = .white
            paymentStatusLabel.displayText("")
        case "inactive":
            borderView.backgroundColor = .borderColor
            paymentStatusLabel.displayText("Inactivo")
        default:
            break
        }
        selectionStyle = .none
    }
}

