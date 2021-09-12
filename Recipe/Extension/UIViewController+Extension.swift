//
//  UIViewController+Extension.swift
//  Recipe
//
//  Created by ekbana on 9/12/21.
//

import UIKit


// MARK: Alerts
extension UIViewController {
    
    func topViewController() -> UIViewController? {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        var top = appDelegate.window?.rootViewController
        while true {
            if let presented = top?.presentedViewController {
                top = presented
            } else if let nav = top as? UINavigationController {
                top = nav.visibleViewController
            } else if let tab = top as? UITabBarController {
                top = tab.selectedViewController
            } else {
                break
            }
        }
        return top
    }
    
    func alert(message: String?, title: String? = nil, okAction: (()->())? = nil) {
//        if type(of: topViewController()) == UIAlertController.self {
//            return
//        }
        let alertController = getAlert(message: message, title: title)
        alertController.addAction(title: "OK", handler: okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func getAlert(message: String?, title: String?, style: UIAlertController.Style? = .alert) -> UIAlertController {
        return UIAlertController(title: title, message: message, preferredStyle: style ?? .alert)
    }
    
    func present(_ alert: UIAlertController, asActionsheetInSourceView sourceView: Any) {
        if UI_USER_INTERFACE_IDIOM() == .pad {
            alert.modalPresentationStyle = .popover
            if let presenter = alert.popoverPresentationController {
                if sourceView is UIBarButtonItem {
                    presenter.barButtonItem = sourceView as? UIBarButtonItem
                }else if sourceView is UIView {
                    let view = sourceView as! UIView
                    presenter.sourceView = view
                    presenter.sourceRect = view.bounds
                }
            }
        }
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension UIAlertController {
    
    func addAction(title: String?, style: UIAlertAction.Style = .default, handler: (()->())? = nil) {
        let action = UIAlertAction(title: title, style: style, handler: {_ in
            handler?()
        })
        self.addAction(action)
    }
    
}
