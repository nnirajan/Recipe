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
            let realmModels: [TourRealmModel] = self.fetch()
            let normalModels = realmModels.map({ $0.normalModel() })
            success(normalModels, pagination)
        }
        
        /// check for network
        if NetworkReachabilityManager()?.isReachable == true {
            let endpoint = EndPoint.tours(ofPage: ofPage)
            
            apiManager.request(endPoint: endpoint, success: { (response: APIResponse<[Tour]>) in
                if let pagination = response.pagination {
//                    if let realmModels = response.data?.map({ $0.realmModel() }) {
//                        /// deleting old tour realm models
//                        if ofPage == 1 {
//                            let oldTourRealmModels: [TourRealmModel] = self.fetch()
//                            self.delete(models: oldTourRealmModels)
//                        }
//                        self.save(models: realmModels)
//                    }
//                    sendSuccess(pagination: pagination)
                    
                    /// deleting old tour realm models
                    if ofPage == 1 {
                        let oldTourRealmModels: [TourRealmModel] = self.fetch()
                        self.delete(models: oldTourRealmModels)
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

// MARK: Tour
struct Tour: Codable {
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
    
    func realmModel() -> TourRealmModel {
        let realmModel = TourRealmModel()
        realmModel.lid = realmModel.incrementID(ofType: TourRealmModel.self, ofProperty: "lid")
        realmModel.id = id ?? 0
        realmModel.title = title ?? ""
        realmModel.imageURL = imageURL ?? ""
        realmModel.tourDescription = description ?? ""
        realmModel.lastUpdated = lastUpdated ?? ""
        realmModel.lastUpdatedSource = lastUpdatedSource ?? ""
        return realmModel
    }
}

// MARK: RealmModels
class TourRealmModel: Object {
    @objc dynamic var lid: Int = 0
    @objc dynamic var id: Int = 0
    @objc dynamic var title: String = ""
    @objc dynamic var imageURL: String = ""
    @objc dynamic var tourDescription: String = ""
    @objc dynamic var lastUpdated: String = ""
    @objc dynamic var lastUpdatedSource: String = ""
    
    override class func primaryKey() -> String? {
        return "lid"
    }
    
    func incrementaID() -> Int{
        return incrementID(ofType: Self.self, ofProperty: "lid")
    }
    
    func normalModel() -> Tour {
        let normalModel = Tour(id: id, title: title, imageURL: imageURL, description: description, lastUpdated: lastUpdated, lastUpdatedSource: lastUpdatedSource)
        return normalModel
    }
}

// MARK: TourListStructure
struct TourListStructure {
    let id: Int?
    let title, imageURL, description: String?
}

// MARK: TourListViewModel
struct TourListViewModel {
    let id: Int?
    let title, imageURL, description: String?
}
