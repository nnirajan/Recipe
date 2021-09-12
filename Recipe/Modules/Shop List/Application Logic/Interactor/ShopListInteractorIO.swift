//
//  ShopListInteractorIO.swift
//  Recipe
//
//  Created by ekbana on 9/12/21.
//
//

protocol ShopListInteractorInput: class {
    func getShops()
    func getMoreShops()
}

protocol ShopListInteractorOutput: class {
    func shopObtained(models: [ShopListStructure], total: Int)
    func errorObtained(error: Error)
}
