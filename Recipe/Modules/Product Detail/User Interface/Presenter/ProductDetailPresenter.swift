//
//  ProductDetailPresenter.swift
//  Recipe
//
//  Created by ekbana on 9/12/21.
//
//

import Foundation

class ProductDetailPresenter {
    
    // MARK: Properties
    weak var view: ProductDetailViewInterface?
    var interactor: ProductDetailInteractorInput?
    var wireframe: ProductDetailWireframeInput?
    
    // MARK: Converting entities
    func convert(model: ProductDetailStructure) -> ProductDetailViewModel {
        ProductDetailViewModel(id: model.id, title: model.title, imageURL: model.imageURL, description: model.description)
    }
    
}

// MARK: ProductDetail module interface
extension ProductDetailPresenter: ProductDetailModuleInterface {
    
    func viewIsReady() {
        view?.showSkeletonLoading()
        interactor?.getProductDetail()
    }
    
}

// MARK: ProductDetail interactor output interface
extension ProductDetailPresenter: ProductDetailInteractorOutput {
    
    func productDetailObtained(model: ProductDetailStructure?) {
        view?.hideSkeletonLoading()
        let viewModel = model.map(convert)
        view?.showProductDetail(model: viewModel)
    }
    
}
