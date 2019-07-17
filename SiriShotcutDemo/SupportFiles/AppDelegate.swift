//
//  AppDelegate.swift
//  SiriShotcutDemo
//
//  Created by Piotr Smajek on 02/04/2019.
//  Copyright © 2019 Miquido. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }
    
    func application(_ application: UIApplication,
                     continue userActivity: NSUserActivity,
                     restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        
        var viewController: UIViewController?
        
        if userActivity.activityType == Identifiers.NSUserActivity {
            viewController = UIStoryboard.instantiateVC(Scene.MakeOrder)
        } else if userActivity.activityType == Identifiers.OrderIntent {
            viewController = UIStoryboard.instantiateVC(Scene.OrdersTableView)
        }
        
        guard let vc = viewController else { return false }
        
        let navigationController: UINavigationController = UIStoryboard.instantiateVC(Scene.NavigationController)
        window?.rootViewController = navigationController
        navigationController.pushViewController(vc, animated: true)
        
        return true
    }


}

