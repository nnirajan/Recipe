//
//  Shop.swift
//  Recipe
//
//  Created by ekbana on 9/12/21.
//

import Foundation
import RealmSwift

// MARK: Shop
struct Shop: Codable {
    let id: Int?
    let title, imageURL, description, lastUpdated, lastUpdatedSource: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case imageURL = "image_url"
        case description
        case lastUpdated = "last_updated"
        case lastUpdatedSource = "last_updated_source"
    }
    
    func realmModel() -> ShopRealmModel {
        let realmModel = ShopRealmModel()
        realmModel.lid = realmModel.incrementaID()
        realmModel.id = id ?? 0
        realmModel.title = title ?? ""
        realmModel.imageURL = imageURL ?? ""
        realmModel.shopDescription = description ?? ""
        realmModel.lastUpdated = lastUpdated ?? ""
        realmModel.lastUpdatedSource = lastUpdatedSource ?? ""
        return realmModel
    }
}

// MARK: RealmModels
class ShopRealmModel: Object {
    @objc dynamic var lid: Int = 0
    @objc dynamic var id: Int = 0
    @objc dynamic var title: String = ""
    @objc dynamic var imageURL: String = ""
    @objc dynamic var shopDescription: String = ""
    @objc dynamic var lastUpdated: String = ""
    @objc dynamic var lastUpdatedSource: String = ""
    
    override class func primaryKey() -> String? {
        return "lid"
    }
    
    func incrementaID() -> Int{
        return incrementID(ofType: Self.self, ofProperty: "lid")
    }
    
    func normalModel() -> Shop {
        let normalModel = Shop(id: id, title: title, imageURL: imageURL, description: description, lastUpdated: lastUpdated, lastUpdatedSource: lastUpdatedSource)
        return normalModel
    }
}
