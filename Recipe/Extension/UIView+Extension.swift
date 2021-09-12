//
//  UIView+Extension.swift
//  Recipe
//
//  Created by ekbana on 9/12/21.
//

import UIKit

extension UIView {
    
    func set(cornerRadius radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
    func set(border: UIColor) {
        self.layer.borderColor = border.cgColor;
    }
    
    func set(borderWidth: CGFloat) {
        self.layer.borderWidth = borderWidth
    }
    
    func set(borderWidth width: CGFloat, of color: UIColor) {
        self.set(border: color)
        self.set(borderWidth: width)
    }
    
    func rounded() {
        self.layer.masksToBounds = true
        self.set(cornerRadius: self.frame.height/2)
    }
    
}
