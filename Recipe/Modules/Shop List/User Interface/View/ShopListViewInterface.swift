//
//  ShopListViewInterface.swift
//  Recipe
//
//  Created by Nirajan on 9/12/21.
//
//

protocol ShopListViewInterface: class {
    func showSkeletonLoading()
    func hideSkeletonLoading()
    func showError(error: Error)
    func showShopList(models: [ShopListViewModel], total: Int)
}
