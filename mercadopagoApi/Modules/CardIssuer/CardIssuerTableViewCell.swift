//
//  CardIssuerTableViewCell.swift
//  mercadopagoApi
//
//  Created by Roberto on 2/10/19.
//  Copyright © 2019 Roberto. All rights reserved.
//

import UIKit

class CardIssuerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var borderView: UIView! {
        didSet {
            borderView.cornerRadius = 4
            borderView.borderColor = .borderColor
            borderView.borderWidth = 1
        }
    }
    @IBOutlet weak var cardIssuerImageView: UIImageView! {
        didSet {
            cardIssuerImageView.backgroundColor = .white
            cardIssuerImageView.contentMode = .scaleAspectFit
        }
    }
    @IBOutlet weak var cardIssuerNameLabel: UILabel! {
        didSet {
            cardIssuerNameLabel.text = ""
            cardIssuerNameLabel.textColor = .primaryFontColor
            cardIssuerNameLabel.font = .body1
        }
    }
    
    var cardIssuerData: CardIssuer? {
        didSet {
            configureCell()
        }
    }

}

// MARK: - LifeCycle
extension CardIssuerTableViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

// MARK: - Methods
extension CardIssuerTableViewCell {
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func configureCell() {
        guard let cardIssuer = cardIssuerData else {
            return
        }
        cardIssuerNameLabel.text = cardIssuer.name
        if let urlString = cardIssuer.thumbnail {
            cardIssuerImageView.kf.setImage(with: URL(string:urlString))
        }
        
        selectionStyle = .none
    }
}

