//
//  ShopListModuleInterface.swift
//  Recipe
//
//  Created by Nirajan on 9/12/21.
//
//

protocol ShopListModuleInterface: class {
    func viewIsReady(isRefreshing: Bool)
    func getMoreData()
    func gotoProductDetailScreen(id: Int)
}
