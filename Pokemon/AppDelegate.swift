//
//  AppDelegate.swift
//  Pokemon
//
//  Created by Ruslan on 21.03.2020.
//  Copyright © 2020 ymakovet. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let tabBar = UITabBarController()
    
        Tab.allCases.forEach { (item) in
            let presenter = PokemonListPresenter(model: item.model)
            let vc = PokemonListViewController(presenter: presenter)
            let navBar = UINavigationController(rootViewController: vc)
            let item = UITabBarItem(title: nil, image: item.image, selectedImage: item.selectedImage)
            item.imageInsets = UIEdgeInsets(top: 9, left: 0, bottom: -9, right: 0)
            navBar.tabBarItem = item
            tabBar.addChild(navBar)
        }
        
        tabBar.tabBar.barTintColor = UIColor(red:0.94, green:0.33, blue:0.31, alpha:1.00)
        tabBar.tabBar.isTranslucent = false

        tabBar.tabBar.unselectedItemTintColor = .white
        tabBar.tabBar.tintColor = .white
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = tabBar
        window?.makeKeyAndVisible()
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return false
    }
    
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        return false
    }
}

