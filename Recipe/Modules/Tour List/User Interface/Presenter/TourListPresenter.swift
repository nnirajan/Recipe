//
//  TourListPresenter.swift
//  Recipe
//
//  Created by ekbana on 9/12/21.
//
//

import Foundation

class TourListPresenter {
    
    // MARK: Properties
    weak var view: TourListViewInterface?
    var interactor: TourListInteractorInput?
    var wireframe: TourListWireframeInput?
    
    // MARK: Converting entities
}

// MARK: TourList module interface
extension TourListPresenter: TourListModuleInterface {
    
}

// MARK: TourList interactor output interface
extension TourListPresenter: TourListInteractorOutput {

    func tourObtained(models: [TourListStructure], total: Int) {
        
    }
    
}
