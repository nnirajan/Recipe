//
//  EndPoint.swift
//  Recipe
//
//  Created by ekbana on 9/12/21.
//

import Foundation
import Alamofire

// MARK: EndPoint
enum EndPoint {
    case tours
    
    var fieldsParams: String {
        "fields=id,title,image,description,intro"
    }
    
    var sort: String {
        "sort=id"
    }
    
    // MARK: HTTPMethod
    var method: HTTPMethod {
        switch self {
        case .tours:
            return .get
        }
    }
    
    // MARK: Path
    var path: String {
        switch self {
        case .tours:
            return "tours?\(fieldsParams)&\(sort)"
        }
    }
    
    // MARK: needsAuthorization
    var needsAuthorization: Bool {
        switch self {
            default:
                return false
        }
    }
    
    // MARK: additionalHeaders
    var additionalHeaders: [String: String]? {
        var headers = [String: String]()
        
        switch self {
        default:
            headers = [:]
        }
        
        return headers
    }
    
}
