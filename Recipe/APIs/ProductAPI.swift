//
//  ProductAPI.swift
//  Recipe
//
//  Created by ekbana on 9/12/21.
//

import Foundation
import Alamofire

protocol ProductAPI: APIServiceType, RealmPersistenceType {
    func getProductDetail(id: Int, success: @escaping (Shop?)->(), failure: @escaping (Error)->())
}

extension ProductAPI {
    
    // MARK: getProductDetail
    func getProductDetail(id: Int, success: @escaping (Shop?)->(), failure: @escaping (Error)->()) {
        /// sendSuccess
        func sendSuccess() {
            let realmModel: ShopRealmModel? = self.fetch(primaryKey: id)
            let normalModel = realmModel?.normalModel()
            success(normalModel)
        }
        
        /// check for network
        if NetworkReachabilityManager()?.isReachable == true {
            let endpoint = EndPoint.productDetail(id: id)
            
            apiManager.request(endPoint: endpoint, success: { (response: APIResponse<Shop>) in
                if let productDetailRealmModel = response.data?.realmModel() {
                    self.save(models: [productDetailRealmModel])
                }
                sendSuccess()
            }) { (error) in
                sendSuccess()
            }
        } else {
            /// sendSuccess if no internet
            sendSuccess()
        }
    }
    
}
