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
    case shops(ofPage: Int)
    
    var fieldsParams: String {
        "fields=id,title,image_url,description,last_updated,last_updated_source"
    }
    
    var sort: String {
        "sort=id"
    }
    
    var limit: String {
        "limit=10"
    }
    
    // MARK: HTTPMethod
    var method: HTTPMethod {
        switch self {
        case .shops:
            return .get
        }
    }
    
    // MARK: Path
    var path: String {
        switch self {
        case .shops(let ofPage):
            return "products?\(fieldsParams)&\(sort)&\(limit)&page=\(ofPage)"
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
