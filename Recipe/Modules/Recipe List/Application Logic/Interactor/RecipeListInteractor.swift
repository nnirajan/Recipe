//
//  RecipeListInteractor.swift
//  Recipe
//
//  Created by ekbana on 9/11/21.
//
//

import Foundation

class RecipeListInteractor {
    
	// MARK: Properties
    
    weak var output: RecipeListInteractorOutput?
    private let service: RecipeListServiceType
    
    // MARK: Initialization
    
    init(service: RecipeListServiceType) {
        self.service = service
    }

    // MARK: Converting entities
}

// MARK: RecipeList interactor input interface

extension RecipeListInteractor: RecipeListInteractorInput {
    
}
