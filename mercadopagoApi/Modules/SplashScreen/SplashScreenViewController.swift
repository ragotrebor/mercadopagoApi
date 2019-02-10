//
//  SplashScreenViewController.swift
//  mercadopagoApi
//
//  Created by Roberto on 2/9/19.
//  Copyright © 2019 Roberto. All rights reserved.
//

import UIKit

class SplashScreenViewController: UIViewController {
    var presenter: SplashScreenPresenterProtocol?
}

// MARK: - Lifecycle
extension SplashScreenViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.onViewDidLoad()
    }
}

// MARK: - View
extension SplashScreenViewController: SplashScreenViewProtocol {}
