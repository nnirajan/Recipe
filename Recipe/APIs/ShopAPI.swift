//
//  ShopAPI.swift
//  Recipe
//
//  Created by ekbana on 9/12/21.
//

import Foundation
import Alamofire

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
            
//            let a = EndPoint.users
//
//
//            apiManager.request(endPoint: a, success: { (response: APIResponse<[Shop]>) in
//
//            }, failure: failure)
            
        } else {
            /// sendSuccess if no internet
            sendSuccess(pagination: nil)
        }
    }
    
    func getUser(success: @escaping ([User], APIPagination?)->(), failure: @escaping (Error)->()) {
        let endpoint = EndPoint.users
        
        apiManager.request(endPoint: endpoint, success: { (response: APIResponse<[User]>) in
            if let users = response.data {
                success(users, nil)
            }
        }, failure: failure)
    }
    
}

struct User: Codable {
    let id: Int?
    let email, first_name, last_name, avatar: String?
    
//    enum CodingKeys: String, CodingKey {
//        case id
//        case title
//        case imageURL = "image_url"
//        case description
//        case lastUpdated = "last_updated"
//        case lastUpdatedSource = "last_updated_source"
//    }
}

