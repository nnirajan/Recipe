//
//  ProductDetailWireframe.swift
//  Recipe
//
//  Created by Nirajan on 9/12/21.
//
//

import UIKit

class ProductDetailWireframe {
    weak var view: UIViewController!
    
    var id: Int?
}

extension ProductDetailWireframe: ProductDetailWireframeInput {
    
    var storyboardName: String {return "ProductDetail"}
    
    func getMainView() -> UIViewController {
        let service = ProductDetailService()
        let interactor = ProductDetailInteractor(service: service)
        let presenter = ProductDetailPresenter()
        let viewController = viewControllerFromStoryboard(of: ProductDetailViewController.self)
        
        viewController.presenter = presenter
        interactor.output = presenter
        interactor.id = id
        presenter.interactor = interactor
        presenter.wireframe = self
        presenter.view = viewController
        
        self.view = viewController
        return viewController
    }
    
    func openProductDetail(id: Int, source: UINavigationController) {
        self.id = id
        source.pushViewController(getMainView(), animated: true)
    }
    
}
