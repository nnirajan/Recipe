//
//  RecipeListWireframe.swift
//  Recipe
//
//  Created by ekbana on 9/11/21.
//
//

import UIKit

class RecipeListWireframe {
     weak var view: UIViewController!
}

extension RecipeListWireframe: RecipeListWireframeInput {
    
    var storyboardName: String {return "RecipeList"}
    
    func getMainView() -> UIViewController {
        let service = RecipeListService()
        let interactor = RecipeListInteractor(service: service)
        let presenter = RecipeListPresenter()
        let viewController = viewControllerFromStoryboard(of: RecipeListViewController.self)
        
        viewController.presenter = presenter
        interactor.output = presenter
        presenter.interactor = interactor
        presenter.wireframe = self
        presenter.view = viewController
        
        self.view = viewController
        return viewController
    }
}
