//
//  TourListWireframe.swift
//  Recipe
//
//  Created by ekbana on 9/12/21.
//
//

import UIKit

class TourListWireframe {
     weak var view: UIViewController!
}

extension TourListWireframe: TourListWireframeInput {
    
    var storyboardName: String {return "TourList"}
    
    func getMainView() -> UIViewController {
        let service = TourListService()
        let interactor = TourListInteractor(service: service)
        let presenter = TourListPresenter()
        let viewController = viewControllerFromStoryboard(of: TourListViewController.self)
        
        viewController.presenter = presenter
        interactor.output = presenter
        presenter.interactor = interactor
        presenter.wireframe = self
        presenter.view = viewController
        
        self.view = viewController
        return viewController
    }
}
