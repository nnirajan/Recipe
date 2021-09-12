//
//  ShopListWireframe.swift
//  Recipe
//
//  Created by ekbana on 9/12/21.
//
//

import UIKit

class ShopListWireframe {
     weak var view: UIViewController!
}

extension ShopListWireframe: ShopListWireframeInput {
    
    var storyboardName: String {return "ShopList"}
    
    func getMainView() -> UIViewController {
        let service = ShopListService()
        let interactor = ShopListInteractor(service: service)
        let presenter = ShopListPresenter()
        let viewController = viewControllerFromStoryboard(of: ShopListViewController.self)
        
        viewController.presenter = presenter
        interactor.output = presenter
        presenter.interactor = interactor
        presenter.wireframe = self
        presenter.view = viewController
        
        self.view = viewController
        return viewController
    }
}
