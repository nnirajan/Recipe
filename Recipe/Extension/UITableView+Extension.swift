//
//  UITableView+Extension.swift
//  Recipe
//
//  Created by Nirajan on 9/12/21.
//

import Foundation

import UIKit

extension UITableView {
    
    func dequeueCell<T: UITableViewCell>() -> T {
        return dequeueReusableCell(withIdentifier: "\(T.self)") as! T
    }

    func dequeueCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: "\(T.self)", for: indexPath) as! T
    }

}
