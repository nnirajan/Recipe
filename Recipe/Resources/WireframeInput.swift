//
//  WireframeInput.swift
//  Recipe
//
//  Created by ekbana on 9/11/21.
//

import Foundation

import UIKit

protocol WireframeInput {
    var window: UIWindow? {get}
    var view: UIViewController! {get}
    var storyboardName: String {get}
    func openMainView(source: UIViewController)
    func pushMainView(on source: UIViewController)
    func pushMainView(in source: UINavigationController)
    func getMainView() -> UIViewController
    func openMainViewIn(window: UIWindow)
    func openViewControllerWithNavigation(viewController: UIViewController, source: UIViewController)
}

extension WireframeInput {
    var window: UIWindow? {
        return (UIApplication.shared.delegate as! AppDelegate).window
    }
    
    func viewControllerFromStoryboard<T: UIViewController>(of type: T.Type) -> T {
        return UIStoryboard(name: storyboardName, bundle: nil).instantiateViewController(withIdentifier: String(describing: T.self)) as! T
    }
    
    func openMainViewIn(window: UIWindow) {
        let view = self.getMainView()
        window.rootViewController = view
    }
    
    func openMainViewAsNavigationControllerIn(window: UIWindow) {
        let view = self.getMainView()
        let nav = UINavigationController.init(rootViewController: view)
        window.rootViewController = nav
    }
    
    func openMainView(source: UIViewController) {
        let mainView = self.getMainView()
        mainView.modalPresentationStyle = .fullScreen
        source.present(mainView, animated: true, completion: nil)
    }
    
    func pushMainView(on source: UIViewController) {
        let mainView = self.getMainView()
        source.navigationController?.pushViewController(mainView, animated: true)
    }
    
    func pushMainView(in source: UINavigationController) {
        let mainView = self.getMainView()
        source.pushViewController(mainView, animated: true)
    }
    
    func openViewControllerWithNavigation(viewController: UIViewController, source: UIViewController) {
        let nav = UINavigationController(rootViewController: viewController)
        nav.modalPresentationStyle = .fullScreen
        source.present(nav, animated: true, completion: nil)
    }
    
    func openViewControllerWithNavigationOverFullScreen(viewController: UIViewController, source: UIViewController) {
        let nav = UINavigationController(rootViewController: viewController)
        nav.modalPresentationStyle = .overFullScreen
        source.present(nav, animated: false, completion: nil)
    }
    
}
