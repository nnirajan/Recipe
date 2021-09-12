//
//  APIResponse.swift
//  Recipe
//
//  Created by ekbana on 9/12/21.
//

import Foundation

// MARK: APIResponse
struct APIResponse<T: Codable>: Codable {
    let data: T?
    let pagination: APIPagination?
    let status: Int?
    let error, detail: String?
}

// MARK: APIPagination
struct APIPagination: Codable {
    let total, limit, offset: Int?
    let totalPages, currentPage: Int?
    let nextURL: String?
    
    enum CodingKeys: String, CodingKey {
        case total, limit, offset
        case totalPages = "total_pages"
        case currentPage = "current_page"
        case nextURL = "next_url"
    }
}


