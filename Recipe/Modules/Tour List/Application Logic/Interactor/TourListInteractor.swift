//
//  TourListInteractor.swift
//  Recipe
//
//  Created by ekbana on 9/12/21.
//
//

import Foundation

class TourListInteractor {
    
    // MARK: Properties
    weak var output: TourListInteractorOutput?
    private let service: TourListServiceType
    
    private var page: Int = 1
    private var tourStructures = [TourListStructure]()
    
    // MARK: Initialization
    init(service: TourListServiceType) {
        self.service = service
    }
    
    // MARK: Converting entities
    func convert(model: Tour) -> TourListStructure {
        TourListStructure(id: model.id, title: model.title, image: model.image, description: model.description, intro: model.intro)
    }
    
}

// MARK: TourList interactor input interface
extension TourListInteractor: TourListInteractorInput {
    
    func getTours() {
        page = 1
        service.getTours(ofPage: page, success: { [weak self] (tours, pagination) in
            guard let self = self else { return }
            self.page += 1
            let structures = tours.map(self.convert)
            self.tourStructures = structures
            self.output?.tourObtained(models: self.tourStructures, total: pagination?.total ?? 0)
        }) { [weak self] (error) in
            guard let self = self else { return }
        }
    }
    
    func getMoreTours() {
        service.getTours(ofPage: page, success: { [weak self] (tours, pagination) in
            guard let self = self else { return }
            self.page += 1
            let structures = tours.map(self.convert)
            self.tourStructures.append(contentsOf: structures)
            self.output?.tourObtained(models: self.tourStructures, total: pagination?.total ?? 0)
        }) { [weak self] (error) in
            guard let self = self else { return }
        }
    }
    
}
