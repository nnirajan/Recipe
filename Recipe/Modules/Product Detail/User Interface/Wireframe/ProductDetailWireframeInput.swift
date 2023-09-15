//
//  ProductDetailWireframeInput.swift
//  Recipe
//
//  Created by Nirajan on 9/12/21.
//
//

import UIKit

protocol ProductDetailWireframeInput: WireframeInput {
    func openProductDetail(id: Int, source: UINavigationController)
}
