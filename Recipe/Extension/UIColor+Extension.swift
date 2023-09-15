//
//  UIColor+Extension.swift
//  Recipe
//
//  Created by Nirajan on 9/12/21.
//

import UIKit

extension UIColor {
    
    convenience init(hexString: String) {
        var hexSanitized = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        let a, r, g, b: CGFloat
        
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        
        switch hexSanitized.count {
        case 6: // RGB (24-bit)
            r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
            g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
            b = CGFloat(rgb & 0x0000FF) / 255.0
            a = 1
        case 8: // ARGB (32-bit)
            r = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
            g = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
            b = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
            a = CGFloat(rgb & 0x000000FF) / 255.0
        default:
            (r, g, b, a) = (0, 0, 0, 1)
        }
        
        self.init(red: r, green: g, blue: b, alpha: a)
    }
    
}
