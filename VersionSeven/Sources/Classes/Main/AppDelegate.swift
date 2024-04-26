import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = rootViewController()
        window?.makeKeyAndVisible()
        
        return true
    }
    
    private func rootViewController() -> UINavigationController {
        let viewController = QuotesViewController()
        let viewModel = QuotesViewModel()
        viewController.viewModel = viewModel
        let navigationController = NavigationController(
            rootViewController: viewController
        )
        return navigationController
    }
}
