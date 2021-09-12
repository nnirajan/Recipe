//
//  ShopListViewInterface.swift
//  Recipe
//
//  Created by ekbana on 9/12/21.
//
//

protocol ShopListViewInterface: class {
    func showSkeletonLoading()
    func hideSkeletonLoading()
    func showShopList(models: [ShopListViewModel], total: Int)
    func user(model: [User])
}
