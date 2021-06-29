//
//  AppDelegate.swift
//  ProvaSicredi
//
//  Created by Rafael Hartmann on 28/06/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coordinator: Coordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
       
        let font:UIFont = UIFont(name: "Montserrat-SemiBold", size: 18.0)!
        let navbarTitleAtt = [
            NSAttributedString.Key.font:font,
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        UINavigationBar.appearance().titleTextAttributes = navbarTitleAtt
        UINavigationBar.appearance().barTintColor = UIColor(red: 252/255, green: 25/255, blue: 63/255, alpha: 1)
        
        self.window = UIWindow.init()
        self.window?.bounds = UIScreen.main.bounds
        let navigation = UINavigationController()
        self.coordinator = HomeCoordinator(navigationController: navigation)
        self.coordinator?.start()
        self.window?.rootViewController = navigation
        self.window?.makeKeyAndVisible()

        return true
       
    }

    // MARK: UISceneSession Lifecycle

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


}

