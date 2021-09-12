//
//  ShopListInteractor.swift
//  Recipe
//
//  Created by ekbana on 9/12/21.
//
//

import Foundation

class ShopListInteractor {
    
    // MARK: Properties
    weak var output: ShopListInteractorOutput?
    private let service: ShopListServiceType
    
    private var page: Int = 1
    private var shopListStructures = [ShopListStructure]()
    
    // MARK: Initialization
    init(service: ShopListServiceType) {
        self.service = service
    }
    
    // MARK: Converting entities
    func convert(model: Shop) -> ShopListStructure {
        ShopListStructure(id: model.id, title: model.title, imageURL: model.imageURL, description: model.description)
    }
    
}

// MARK: ShopList interactor input interface
extension ShopListInteractor: ShopListInteractorInput {
    
    func getTours() {
        page = 1
        service.getShops(ofPage: page, success: { [weak self] (tours, pagination) in
            guard let self = self else { return }
            self.page += 1
            let structures = tours.map(self.convert)
            self.shopListStructures = structures
            self.output?.tourObtained(models: self.shopListStructures, total: pagination?.total ?? 0)
        }) { [weak self] (error) in
            guard let self = self else { return }
        }
    }
    
    func getMoreTours() {
        service.getShops(ofPage: page, success: { [weak self] (tours, pagination) in
            guard let self = self else { return }
            self.page += 1
            let structures = tours.map(self.convert)
            self.shopListStructures = structures
            self.output?.tourObtained(models: self.shopListStructures, total: pagination?.total ?? 0)
        }) { [weak self] (error) in
            guard let self = self else { return }
        }
    }
    
}
