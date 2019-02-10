//
//  PaymentViewController.swift
//  mercadopagoApi
//
//  Created by Roberto on 2/10/19.
//  Copyright © 2019 Roberto. All rights reserved.
//

import UIKit
import Kingfisher

class PaymentViewController: UIViewController {
    
    @IBOutlet weak var paymentTableView: UITableView! {
        didSet {
            paymentTableView.dataSource = self
            paymentTableView.delegate = self
            paymentTableView.separatorStyle = .none
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
    
    var presenter: PaymentPresenterProcotol?
    
    var dataSource: [Payment]? {
        didSet {
            paymentTableView.reloadData()
        }
    }
    
    
}

// MARK: - View
extension PaymentViewController: PaymentViewProtocol {
    func set(dataSource: [Payment]) {
        self.dataSource = dataSource
    }
    
    func startActivityIndicator() {
        activityIndicator.startAnimating()
    }
    
    func stopActivityIndicator() {
        activityIndicator.stopAnimating()
    }
    
}

// MARK: - Lifecycle
extension PaymentViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.onViewDidLoad()
    }
}

// MARK: - Tableview methods
extension PaymentViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "paymentCell", for: indexPath) as! PaymentTableViewCell
        
        if let payment = dataSource?[indexPath.row] {
            cell.paymentData = payment
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.onPaymentMethodSelected(index: indexPath.row)
    }
    
}

//MARK: - UI Event Handlers
extension PaymentViewController {
    @objc func backButtonTouched(sender: UIButton) {
        presenter?.onBackButtonTouched()
    }
}
