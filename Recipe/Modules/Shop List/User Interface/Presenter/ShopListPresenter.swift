//
//  ShopListPresenter.swift
//  Recipe
//
//  Created by ekbana on 9/12/21.
//
//

import Foundation

class ShopListPresenter {
    
    // MARK: Properties
    weak var view: ShopListViewInterface?
    var interactor: ShopListInteractorInput?
    var wireframe: ShopListWireframeInput?
    
    // MARK: Converting entities
    func convert(model: ShopListStructure) -> ShopListViewModel {
        ShopListViewModel(id: model.id, title: model.title, imageURL: model.imageURL, description: model.description)
    }
    
}

// MARK: ShopList module interface
extension ShopListPresenter: ShopListModuleInterface {
    
    func viewIsReady(isRefreshing: Bool) {
        if !isRefreshing {
            view?.showSkeletonLoading()
        }
        interactor?.getShops()
    }
    
    func getMoreData() {
        interactor?.getMoreShops()
    }
    
}

// MARK: ShopList interactor output interface
extension ShopListPresenter: ShopListInteractorOutput {

    func shopObtained(models: [ShopListStructure], total: Int) {
        view?.hideSkeletonLoading()
        let viewModels = models.map(convert)
        view?.showShopList(models: viewModels, total: total)
    }
    
}
