//
//  InstallmentViewController.swift
//  mercadopagoApi
//
//  Created by Roberto on 2/10/19.
//  Copyright © 2019 Roberto. All rights reserved.
//

import UIKit

class InstallmentViewController: UIViewController {
    
    @IBOutlet weak var installmentTableView: UITableView! {
        didSet {
            installmentTableView.dataSource = self
            installmentTableView.delegate = self
            installmentTableView.separatorStyle = .none
        }
    }
    
    @IBOutlet weak var tableViewTotalLabel: UILabel! {
        didSet {
            tableViewTotalLabel.text = "Total"
            tableViewTotalLabel.textColor = .primaryFontColor
            tableViewTotalLabel.font = .body1
            tableViewTotalLabel.isHidden = true
        }
    }
    
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView! {
        didSet {
            activityIndicator.style = .gray
            activityIndicator.hidesWhenStopped = true
        }
    }
    
    var presenter: InstallmentPresenterProcotol?
    
    var dataSource: [PayerCost]? {
        didSet {
            installmentTableView.reloadData()
        }
    }
}

// MARK: - Lifecycle
extension InstallmentViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.onViewDidLoad()
    }
}

// MARK: - Tableview methods
extension InstallmentViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "installmentCell", for: indexPath) as! InstallmentTableViewCell
        
        if let installment = dataSource?[indexPath.row] {
            cell.installmentData = installment
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.onInstallmentSelected(index: indexPath.row)
    }
    
}

//MARK: - View
extension InstallmentViewController: InstallmentViewProtocol {
    func set(dataSource: [PayerCost]) {
        self.dataSource = dataSource
    }
    
    func startActivityIndicator() {
        activityIndicator.startAnimating()
    }
    
    func stopActivityIndicator() {
        activityIndicator.stopAnimating()
        tableViewTotalLabel.isHidden = false
    }
    
}
