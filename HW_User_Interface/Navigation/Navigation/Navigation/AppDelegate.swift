//
//  AppDelegate.swift
//  Navigation
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .darkGray
        
        
        let statTBController = UITabBarController()
        statTBController.view.backgroundColor = .blue

        let userFeedNController = UINavigationController()
        let feedViewController = UIViewController()
        feedViewController.view.backgroundColor = .cyan
        userFeedNController.tabBarItem = UITabBarItem(tabBarSystemItem: .history , tag: 0)
        userFeedNController.setViewControllers([feedViewController], animated: true)
        
        let profileNController = UINavigationController()
        let profileViewController = UIViewController()
        profileViewController.view.backgroundColor = .brown
        profileNController.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts , tag: 1)
        profileNController.setViewControllers([profileViewController], animated: true)

        statTBController.viewControllers = [userFeedNController,profileNController]
        
        window?.rootViewController = statTBController
        window?.makeKeyAndVisible()
        return true
    }

    // MARK: UISceneSession Lifecycle
/*
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
*/

}

