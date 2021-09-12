//
//  ShopListInteractorIO.swift
//  Recipe
//
//  Created by ekbana on 9/12/21.
//
//

protocol ShopListInteractorInput: class {
    func getTours()
    func getMoreTours()
}

protocol ShopListInteractorOutput: class {
    func tourObtained(models: [ShopListStructure], total: Int)
}
