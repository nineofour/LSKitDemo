//
//  NetworkManager.swift
//  Instogram
//
//  Created by syrup on 2021/2/15.
//

import Foundation
import Alamofire

private let NetworkAPIBaseURL = ""

typealias NetworkRequestResult = Result<Data, Error>
typealias NetworkRequestCompletion = (NetworkRequestResult) -> Void

class NetworkManager {
    
    static let shared = NetworkManager()
    
    var commonHeaders: HTTPHeaders { ["Token": "123", "user_id": "456"] }
    
    private init() {}
    
    @discardableResult
    func requestGet(path: String, parameters: Parameters?, completion: @escaping NetworkRequestCompletion) -> DataRequest  {
        
        AF.request(NetworkAPIBaseURL + path,
                   parameters: parameters,
                   headers: commonHeaders,
                   requestModifier: { $0.timeoutInterval = 15 })
            .responseData { response in
                switch response.result {
                case let .success(data): completion(.success(data))
                case let .failure(error): completion(.failure(error))
                }
            }
    }
    
    @discardableResult
    func requestPost(path: String, parameters: Parameters?, completion: @escaping NetworkRequestCompletion) -> DataRequest  {
        
        AF.request(NetworkAPIBaseURL + path,
                   method: .post,
                   encoding: JSONEncoding.prettyPrinted,
                   headers: commonHeaders,
                   requestModifier: {$0.timeoutInterval = 15 })
            .responseData { response in
                switch response.result {
                case let .success(data): completion(.success(data))
                case let .failure(error): completion(.failure(error))
                }
            }
    }
}
