//
//  Auth.swift
//  Recipe
//
//  Created by ekbana on 9/11/21.
//

import Foundation
import Alamofire

// MARK: DeploymentMode
struct DeploymentMode: OptionSet {
    typealias RawValue = Int
    
    static func ==(lhs: DeploymentMode, rhs: DeploymentMode) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }
    
    var rawValue: DeploymentMode.RawValue
    static let dev: DeploymentMode = DeploymentMode(rawValue: 0)
}

// MARK: Configuration
struct Configuration {
    let clientID: String
    let clientSecret: String
    let apiKey: String
    let baseURL: String
    
    static var config: Configuration {
        switch deploymentMode {
        case .dev:
            return Configuration(
                clientID: "",
                clientSecret: "",
                apiKey: "",
                baseURL: "https://api.artic.edu/api/v1/"
            )
        default:
            return Configuration(
                clientID: "",
                clientSecret: "",
                apiKey: "",
                baseURL: "https://api.artic.edu/api/v1/"
            )
        }
    }
}

// MARK: HTTPHeaderField
enum HTTPHeaderField: String {
    case authorization = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

// MARK: ContentType
enum ContentType: String {
    case json = "application/json"
    case bearer = "Bearer"
}

protocol APIServiceType {
}

extension APIServiceType {
    var apiManager: Auth { return Auth.shared }
}

// MARK: Auth
class Auth {
    static let shared = Auth()
    
    // MARK: initial request
    func request<T>(endPoint: EndPoint, parameters: [String: Any]? = nil, success: @escaping (APIResponse<T>)->(), failure: @escaping (Error)->()) {
        let additionalHeaders = endPoint.additionalHeaders ?? [:]
        let headers = HTTPHeaders.init(additionalHeaders)
        let url = Configuration.config.baseURL + endPoint.path
        
        let alamofireRequest = AF.request(url, method: endPoint.method, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
        alamofireRequest.handle(success: success, failure: failure)
    }
    
}

// MARK: Alamofire.DataRequest extension
extension Alamofire.DataRequest {
    
    // MARK: handle json response
    func handle<T>(success: @escaping (APIResponse<T>)->(), failure: @escaping (Error)->()) {
        self.responseJSON { (response) in
            let statusCode = response.response?.statusCode ?? 500
            
            switch response.result {
            case .success(let value):
                if let json = try? JSONSerialization.data(withJSONObject: value) {
                    if let apiResponse = try? JSONSerialization.jsonObject(with: json, options: .allowFragments) {
                        print("API Response: \n", apiResponse)
                    }
                    
                    // decoding json response
                    let decoder = JSONDecoder()
                    do {
                        let decodedModel = try decoder.decode(APIResponse<T>.self, from: json)
                        
                        // error send data
//                        if let errors = decodedModel.status.errors {
//                            print("API Errors: \n", errors)
//                            handleError(error: errors.first?.customError, failure: failure)
//                            return
//                        }
                        
                        if statusCode == 401 {
                            let error = NSError(domain: "unauthorized", code: 401, userInfo: [NSLocalizedDescriptionKey: decodedModel.detail ?? ""])
//                            handleStatusCode(statusCode: statusCode, error: error)
                            return
                        }
                        
                        // success send data
                        if (200..<300).contains(statusCode) {
                            success(decodedModel)
                            return
                        }
                    } catch {
                        print("Mapping error: " + error.localizedDescription)
                        print(error)
                    }
                }
                
            case .failure(let error):
                print(error)
            }
            
            let error = response.error
//            failure(error ?? GlobalConstants.Error.oops)
//            handleError(error: error, failure: failure)
        }
    }
    
}

// MARK: handleStatusCode
//func handleStatusCode(statusCode: Int, error: Error? = nil) {
//    if let statusCode = StatusCode(rawValue: statusCode) {
//        //logout if error 401 unauthorized
//        if statusCode == .unauthorized {
//            NotificationCenter.default.post(name: GlobalConstants.Notification.unauthorized.notificationName, object: error)
//            return
//        }
//    }
//}

// MARK: handleError
//func handleError(error: Error?, failure: @escaping (Error)->()) {
//    var err = error
//
//    if let afError = error?.asAFError {
//        switch afError {
//        case .sessionTaskFailed(let sessionError):
//            if let code = (sessionError as? URLError)?.code {
//                if code == URLError.notConnectedToInternet || code == URLError.networkConnectionLost {
//                    err = GlobalConstants.Error.internetConnectionOffline
//                }
//            }
//        default:
//            err = GlobalConstants.Error.oops
//        }
//    }
//
//    failure(err ?? GlobalConstants.Error.oops)
//}
