//
//  UIImageView+Extension.swift
//  Recipe
//
//  Created by ekbana on 9/12/21.
//

import Foundation
import Kingfisher

extension UIImageView {
    
    func setImage(urlString: String?, placeHolderImage: UIImage? = UIImage(named: "placeholderImage"), completion: ((UIImage?)->())? = nil) {
        kf.indicatorType = .activity
        if let urlString = urlString,
           let encodedURLString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
           let url = URL(string: encodedURLString) {
            self.kf.setImage(with: url, placeholder: placeHolderImage) { (imageResult) in
                switch imageResult {
                case .success(let imageResult):
                    completion?(imageResult.image)
                case .failure:
                    completion?(nil)
                }
            }
        } else {
            image = placeHolderImage
        }
    }
    
}
