import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    var coordinator: Coordinator?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScence = (scene as? UIWindowScene) else { return }
        
        let navigation = UINavigationController()
        
        let font:UIFont = UIFont(name: "Montserrat-SemiBold", size: 18.0)!
        let navbarTitleAtt = [
            NSAttributedString.Key.font:font,
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        UINavigationBar.appearance().titleTextAttributes = navbarTitleAtt
        UINavigationBar.appearance().barTintColor = CustomColors.SecondColor
        
        window = UIWindow(frame: windowScence.coordinateSpace.bounds)
        window?.windowScene = windowScence
        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
        coordinator = HomeCoordinator(navigationController: navigation)
        coordinator?.start()
        
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
   
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
 
    }
    
    func sceneWillResignActive(_ scene: UIScene) {

    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {

    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        
    }
    
    
}

