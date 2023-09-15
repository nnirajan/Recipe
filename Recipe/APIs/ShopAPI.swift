//
//  ShopAPI.swift
//  Recipe
//
//  Created by Nirajan on 9/12/21.
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
//            let realmModels: [ShopRealmModel] = self.fetch()
            let realmModels: [ShopRealmModel] = self.fetch(sortedBy: ("lid", true))
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
