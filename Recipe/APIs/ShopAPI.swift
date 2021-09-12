//
//  ShopAPI.swift
//  Recipe
//
//  Created by ekbana on 9/12/21.
//

import Foundation
import Alamofire
import RealmSwift

protocol ShopAPI: APIServiceType, RealmPersistenceType {
    func getShops(ofPage: Int, success: @escaping ([Shop], APIPagination?)->(), failure: @escaping (Error)->())
}

extension ShopAPI {
    
    // MARK: getShops
    func getShops(ofPage: Int, success: @escaping ([Shop], APIPagination?)->(), failure: @escaping (Error)->()) {
        /// sendSuccess
        func sendSuccess(pagination: APIPagination?) {
            let realmModels: [ShopRealmModel] = self.fetch()
            let normalModels = realmModels.map({ $0.normalModel() })
            success(normalModels, pagination)
        }
        
        /// check for network
        if NetworkReachabilityManager()?.isReachable == true {
            let endpoint = EndPoint.shops(ofPage: ofPage)
            
            apiManager.request(endPoint: endpoint, success: { (response: APIResponse<[Shop]>) in
                if let pagination = response.pagination {
//                    if let realmModels = response.data?.map({ $0.realmModel() }) {
//                        /// deleting old shop realm models
//                        if ofPage == 1 {
//                            let oldShopRealmModels: [ShopRealmModel] = self.fetch()
//                            self.delete(models: oldShopRealmModels)
//                        }
//                        self.save(models: realmModels)
//                    }
//                    sendSuccess(pagination: pagination)
                    
                    /// deleting old shop realm models
                    if ofPage == 1 {
                        let oldShopRealmModels: [ShopRealmModel] = self.fetch()
                        self.delete(models: oldShopRealmModels)
                    }

                    response.data?.forEach({
                        let realmModel = $0.realmModel()
                        self.save(models: [realmModel])
                    })

                    sendSuccess(pagination: pagination)
                }
            }) { error in
                sendSuccess(pagination: nil)
            }
        } else {
            /// sendSuccess if no internet
            sendSuccess(pagination: nil)
        }
    }
    
}

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
        realmModel.lid = realmModel.incrementID(ofType: ShopRealmModel.self, ofProperty: "lid")
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

// MARK: ShopListStructure
struct ShopListStructure {
    let id: Int?
    let title, imageURL, description: String?
}

// MARK: ShopListViewModel
struct ShopListViewModel {
    let id: Int?
    let title, imageURL, description: String?
}
