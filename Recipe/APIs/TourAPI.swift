//
//  TourAPI.swift
//  Recipe
//
//  Created by ekbana on 9/12/21.
//

import Foundation
import Alamofire
import RealmSwift

protocol TourAPI: APIServiceType, RealmPersistenceType {
    func getTours(ofPage: Int, success: @escaping ([Tour], APIPagination?)->(), failure: @escaping (Error)->())
}

extension TourAPI {
    
    // MARK: getTours
    func getTours(ofPage: Int, success: @escaping ([Tour], APIPagination?)->(), failure: @escaping (Error)->()) {
        /// sendSuccess
        func sendSuccess(pagination: APIPagination?) {
            let realmModels: [TourRealmModel] = self.fetch(sortedBy: ("id", false))
            let normalModels = realmModels.map({ $0.normalModel() })
            success(normalModels, pagination)
        }
        
        /// check for network
        if NetworkReachabilityManager()?.isReachable == true {
            let endpoint = EndPoint.tours
            
            apiManager.request(endPoint: endpoint, success: { (response: APIResponse<[Tour]>) in
                if let tours = response.data, let pagination = response.pagination {
                    success(tours, pagination)
                }
                
                if let pagination = response.pagination {
                    if let realmModels = response.data?.map({ $0.realmModel() }) {
                        /// deleting old tour realm models
                        if ofPage == 1 {
                            let oldTourRealmModels: [TourRealmModel] = self.fetch()
                            self.delete(models: oldTourRealmModels)
                        }
                        self.save(models: realmModels)
                    }
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

// MARK: Tour
struct Tour: Codable {
    let id: Int?
    let title, image, description, intro: String?
    
    func realmModel() -> TourRealmModel {
        let realmModel = TourRealmModel()
        realmModel.id = id ?? -1
        realmModel.title = title ?? ""
        realmModel.image = image ?? ""
        realmModel.tourDescription = description ?? ""
        realmModel.intro = intro ?? ""
        return realmModel
    }
}

// MARK: RealmModels
class TourRealmModel: Object {
    @objc dynamic var id: Int = -1
    @objc dynamic var title: String = ""
    @objc dynamic var image: String = ""
    @objc dynamic var tourDescription: String = ""
    @objc dynamic var intro: String = ""
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    func normalModel() -> Tour {
        let normalModel = Tour(id: id, title: title, image: image, description: description, intro: intro)
        return normalModel
    }
}

// MARK: Tour
struct TourListStructure: Codable {
    let id: Int?
    let title, image, description, intro: String?
}
