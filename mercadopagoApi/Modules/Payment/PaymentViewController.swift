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
        }
    }
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView! {
        didSet {
            activityIndicator.style = .gray
            activityIndicator.hidesWhenStopped = true
        }
    }
    var presenter: PaymentPresenterProcotol?
    
    var dataSource: [Payment]? {
        didSet {
            paymentTableView.reloadData()
        }
    }
}


// MARK: - Lifecycle
extension PaymentViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        if let navigationcController = navigationController {
            navigationController?.title = "Metodo de pago"
        }
    }
}

extension PaymentViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "paymentCell", for: indexPath)
        return cell
    }
    
    
}
