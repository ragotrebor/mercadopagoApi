//
//  InstallmentTableViewCell.swift
//  mercadopagoApi
//
//  Created by Roberto on 2/10/19.
//  Copyright © 2019 Roberto. All rights reserved.
//

import UIKit

class InstallmentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var borderView: UIView! {
        didSet {
            borderView.cornerRadius = 4
            borderView.borderColor = .borderColor
            borderView.borderWidth = 1
        }
    }
    
    @IBOutlet weak var installmentMessageLabel: UILabel! {
        didSet {
            installmentMessageLabel.text = ""
            installmentMessageLabel.textColor = .primaryFontColor
            installmentMessageLabel.font = .body1
        }
    }
    
    @IBOutlet weak var installmentTotalLabel: UILabel! {
        didSet {
            installmentTotalLabel.text = ""
            installmentTotalLabel.textColor = .primaryFontColor
            installmentTotalLabel.font = .body1
        }
    }
    
    var installmentData: PayerCost? {
        didSet {
            configureCell()
        }
    }

}

// MARK: - LifeCycle
extension InstallmentTableViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

// MARK: - Methods
extension InstallmentTableViewCell {
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func configureCell() {
        guard let installment = installmentData else {
            return
        }
        installmentMessageLabel.text = installment.recommendedMessage
        installmentTotalLabel.text = String(installment.totalAmount ?? 0)
        selectionStyle = .none
    }
}
