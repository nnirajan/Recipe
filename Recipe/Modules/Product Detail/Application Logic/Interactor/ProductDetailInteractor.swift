//
//  ProductDetailInteractor.swift
//  Recipe
//
//  Created by Nirajan on 9/12/21.
//
//

import Foundation

class ProductDetailInteractor {
    
    // MARK: Properties
    weak var output: ProductDetailInteractorOutput?
    private let service: ProductDetailServiceType
    
    var id: Int?
    
    // MARK: Initialization
    init(service: ProductDetailServiceType) {
        self.service = service
    }
    
    // MARK: Converting entities
    func convert(model: Shop) -> ProductDetailStructure {
        ProductDetailStructure(id: model.id ?? -1, title: model.title ?? "", imageURL: model.imageURL ?? "", description: model.description ?? "")
    }
    
}

// MARK: ProductDetail interactor input interface
extension ProductDetailInteractor: ProductDetailInteractorInput {
    
    func getProductDetail() {
        if let id = id {
            service.getProductDetail(id: id, success: { [weak self] productDetail in
                guard let self = self else { return }
                let structure = productDetail.map(self.convert)
                self.output?.productDetailObtained(model: structure)
            }) { [weak self] (error) in
                guard let self = self else { return }
                self.output?.errorObtained(error: error)
            }
        }
    }
    
}
