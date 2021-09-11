//
//  RecipeListPresenter.swift
//  Recipe
//
//  Created by ekbana on 9/11/21.
//
//

import Foundation

class RecipeListPresenter {
    
	// MARK: Properties
    
    weak var view: RecipeListViewInterface?
    var interactor: RecipeListInteractorInput?
    var wireframe: RecipeListWireframeInput?

    // MARK: Converting entities
}

 // MARK: RecipeList module interface

extension RecipeListPresenter: RecipeListModuleInterface {
    
}

// MARK: RecipeList interactor output interface

extension RecipeListPresenter: RecipeListInteractorOutput {
    
}
