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
    private lazy var productDetailWireframe: ProductDetailWireframeInput = {ProductDetailWireframe()}()
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
    
    func openProductDetailScreen(id: Int) {
        if let navVC = view.navigationController {
            productDetailWireframe.openProductDetail(id: id, source: navVC)
        }
    }
    
}
