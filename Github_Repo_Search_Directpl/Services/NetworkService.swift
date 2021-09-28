//
//  NetworkService.swift
//  Github_Repo_Search_Directpl
//
//  Created by Joyce on 9/27/21.
//

import Foundation
import Moya
import SwiftyJSON

enum APIEnvironment {
    case staging
    case qa
    case production
}

typealias repositoriesCompletionBlock = (Repositories) -> Void
typealias errorCompletionBlock = (NetworkError) -> Void
typealias failedBlock = (MoyaError) -> Void

protocol Networkable {
    var provider: MoyaProvider<NetworkAPI> { get }
    func searchRepositories(
        keyword: String,
        completion: @escaping repositoriesCompletionBlock,
        errorCompletion: @escaping errorCompletionBlock,
        failed: @escaping failedBlock)
}

struct NetworkService: Networkable {
    var provider: MoyaProvider<NetworkAPI>
    static let environment: APIEnvironment = .staging
    init(provider: MoyaProvider<NetworkAPI> = MoyaProvider<NetworkAPI>(plugins: [ HeaderPlugin() ])) {
        self.provider = provider
    }
    
    func searchRepositories(
        keyword: String,
        completion: @escaping repositoriesCompletionBlock,
        errorCompletion: @escaping errorCompletionBlock,
        failed: @escaping failedBlock) {
         provider.request(
            .searchRepositories(keyword: keyword),
            completion: { response in
                switch response {
                    case .success(let response):
                        switch response.statusCode {
                        case 200, 201:
                            let repositories = Repositories(json: JSON(response.data)[RepositoryKey.items])
                            completion(repositories)
                        case 400:
                            errorCompletion(NetworkError.badRequest)
                        default:
                            errorCompletion(NetworkError.unknown)
                        }
                    case .failure(let error):
                        print(error)
                        failed(error)
                }
            })
    }
    
}

struct HeaderPlugin: PluginType {
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        let request = request
//        if let token = KeychainSwift().get(GlobalConstant.keychain.authToken) {
//            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
//        }
        //request.cachePolicy = .reloadIgnoringCacheData
        return request
    }
}

