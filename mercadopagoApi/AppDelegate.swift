//
//  AppDelegate.swift
//  mercadopagoApi
//
//  Created by Roberto on 2/9/19.
//  Copyright © 2019 Roberto. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
}

//MARK: - Delegate Methods

extension AppDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        setInitialVc()
        
        return true
    }
    
    func setInitialVc() {
        let splashVc = AmountPresenter.createModule()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = splashVc
        window?.makeKeyAndVisible()
    }
}
