//
//  NetworkError.swift
//  Github_Repo_Search_Directpl
//
//  Created by Joyce on 9/27/21.
//

import Foundation

enum NetworkError: Swift.Error, CustomStringConvertible {
    case badRequest
    case unknown
    
    var title: String {
        switch self {
        case .badRequest:
            return Message.badRequestTitle
        case .unknown:
            return Message.unknownTitle
        }
    }
    
    var description: String {
        switch self {
        case .badRequest:
            return Message.badRequestDescription
        case .unknown:
            return Message.unknownDescription
        }
    }
    
}
