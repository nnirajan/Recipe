//
//  ProductDetailInteractorIO.swift
//  Recipe
//
//  Created by ekbana on 9/12/21.
//
//

protocol ProductDetailInteractorInput: class {
    func getProductDetail()
}

protocol ProductDetailInteractorOutput: class {
    func productDetailObtained(model: ProductDetailStructure?)
}
