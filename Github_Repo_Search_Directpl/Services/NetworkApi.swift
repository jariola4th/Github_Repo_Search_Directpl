//
//  NetworkApi.swift
//  Github_Repo_Search_Directpl
//
//  Created by Joyce on 9/27/21.
//

import Foundation
import Moya
import SwiftyJSON

enum NetworkAPI{
    case searchRepositories(keyword: String)
}

extension NetworkAPI: TargetType {
    var environmentBaseUrl: String {
        switch NetworkService.environment {
        case .staging: return Network.baseURL
            case .qa: return "TODO"
            case .production: return "TODO"
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseUrl) else {
            fatalError("BaseAPI: Base URL could not be configured")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .searchRepositories(keyword: _):
            return Endpoint.searchRepo
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .searchRepositories(keyword: _):
            return .get
        }
    }
    
    var sampleData: Data {
        switch self {
        case .searchRepositories(keyword: _):
            return stubbedResponse(File.searchResponse)
        }
    }
    
    var task: Task {
        switch self {
        case .searchRepositories(keyword: _):
            return .requestParameters(parameters: parameters!, encoding: URLEncoding.queryString)
        }
    }
    
    var multipartBody :[MultipartFormData]?{
        switch self {
        case .searchRepositories(keyword: _):
            return []
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .searchRepositories(keyword: let keyword):
            var parameters = [String: Any]()
            parameters["q"] = keyword
            return parameters
        }
    }
    
}

func stubbedResponse(_ filename: String) -> Data! {
    @objc class TestClass: NSObject {
    }
    
    let bundle = Bundle(for: TestClass.self)
    let path = bundle.path(forResource: filename, ofType: "json")
    return (try? Data(contentsOf: URL(fileURLWithPath: path!)))
}


