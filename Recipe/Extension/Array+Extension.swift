//
//  Array+Extension.swift
//  Recipe
//
//  Created by ekbana on 9/12/21.
//

import Foundation

extension Array {
    
    func element(at index: Int) -> Element? {
        if index < count && index >= 0 {
            return self[index]
        }
        return nil
    }
    
}
