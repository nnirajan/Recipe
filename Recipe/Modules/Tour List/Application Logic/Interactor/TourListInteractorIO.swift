//
//  TourListInteractorIO.swift
//  Recipe
//
//  Created by ekbana on 9/12/21.
//
//

protocol TourListInteractorInput: class {
    func getTours()
    func getMoreTours()
}

protocol TourListInteractorOutput: class {
    func tourObtained(models: [TourListStructure], total: Int)
}
