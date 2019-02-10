//
//  CardIssuerViewController.swift
//  mercadopagoApi
//
//  Created by Roberto on 2/10/19.
//  Copyright © 2019 Roberto. All rights reserved.
//

import UIKit

class CardIssuerViewController: UIViewController {
    
    @IBOutlet weak var cardIssuerTableView: UITableView! {
        didSet {
            cardIssuerTableView.dataSource = self
            cardIssuerTableView.delegate = self
            cardIssuerTableView.separatorStyle = .none
        }
    }
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView! {
        didSet {
            activityIndicator.style = .gray
            activityIndicator.hidesWhenStopped = true
        }
    }
    
    @IBOutlet weak var backButton: UIBarButtonItem! {
        didSet {
            backButton.addTargetForAction(target: self,
                                          action: #selector(backButtonTouched(sender:)))
        }
    }
    
    var presenter: CardIssuerPresenterProcotol?
    
    var dataSource: [CardIssuer]? {
        didSet {
            cardIssuerTableView.reloadData()
        }
    }

}

// MARK: - Lifecycle
extension CardIssuerViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.onViewDidLoad()
    }
}

// MARK: - Tableview methods
extension CardIssuerViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cardIssuerCell", for: indexPath) as! CardIssuerTableViewCell
        
        if let cardIssuer = dataSource?[indexPath.row] {
            cell.cardIssuerData = cardIssuer
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.onCardIssuerSelected(index: indexPath.row)
    }
    
}

//MARK: - View
extension CardIssuerViewController: CardIssuerViewProtocol {
    func set(dataSource: [CardIssuer]) {
        self.dataSource = dataSource
    }
    
    func startActivityIndicator() {
        activityIndicator.startAnimating()
    }
    
    func stopActivityIndicator() {
        activityIndicator.stopAnimating()
    }
    
}

//MARK: - UI Event Handlers
extension CardIssuerViewController {
    @objc func backButtonTouched(sender: UIButton) {
        presenter?.onBackButtonTouched()
    }
}
