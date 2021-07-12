
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var coordinator: Coordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        if #available(iOS 13.0, *) {
            
        }else{
            let font:UIFont = UIFont(name: "Montserrat-SemiBold", size: 18.0)!
            let navbarTitleAtt = [
                NSAttributedString.Key.font:font
            ]
            UINavigationBar.appearance().titleTextAttributes = navbarTitleAtt
            UINavigationBar.appearance().barTintColor = CustomColors.SecondColor
            self.window = UIWindow.init()
            self.window?.bounds = UIScreen.main.bounds
            let navigation = UINavigationController()
            self.coordinator = HomeCoordinator(navigationController: navigation)
            self.coordinator?.start()
            self.window?.rootViewController = navigation
            self.window?.makeKeyAndVisible()
        }
        return true
        
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
    
    
}

