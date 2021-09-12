//
//  ProductDetailViewInterface.swift
//  Recipe
//
//  Created by ekbana on 9/12/21.
//
//

protocol ProductDetailViewInterface: class {
    func showSkeletonLoading()
    func hideSkeletonLoading()
    func showProductDetail(model: ProductDetailViewModel?)
}
