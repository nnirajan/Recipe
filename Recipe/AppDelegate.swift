//
//  AppDelegate.swift
//  Recipe
//
//  Created by ekbana on 9/11/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        setupEntryPoint()
        return true
    }
    
    // MARK: setupEntryPoint
    private func setupEntryPoint() {
        window = UIWindow(frame: UIScreen.main.bounds)
        let recipeVC: UIViewController = RecipeListWireframe().getMainView()
        let rootVC = UINavigationController(rootViewController: recipeVC)
        window?.rootViewController = rootVC
        window?.makeKeyAndVisible()
    }
    
}
