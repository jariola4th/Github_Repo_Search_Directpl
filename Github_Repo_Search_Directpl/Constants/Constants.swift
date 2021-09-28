//
//  Constants.swift
//  Github_Repo_Search_Directpl
//
//  Created by Joyce on 9/27/21.
//

import Foundation

/// Storyboard Identifiers
enum Storyboard {
    static let searchScreen = "SearchScreen"
}

/// Tableview Cell  Identifiers
enum Cell {
    static let searchCell = "SearchCell"
}

/// Network Links
enum Network {
    static let baseURL = "https://api.github.com/"
    static let searchRepo = baseURL + Endpoint.searchRepo
    //https://api.github.com/search/repositories?q=swift
}

/// Network API Endpoints
enum Endpoint {
    static let searchRepo = "search/repositories"
}

/// Repositiory Response' Keys
enum RepositoryKey {
    static let items = "items"
    static let id = "id"
    static let name = "name"
    static let description = "description"
    static let htmlUrl = "html_url"
    static let starCount = "stargazers_count"
    static let forkCount = "forks_count"
    static let owner = "owner"
}

/// Owner Response' Keys
enum OwnerKey {
    static let id = "id"
    static let name = "login"
    static let avatarUrl = "avatar_url"
}

/// Network request status for Car List
enum FetchStatus {
    case notStarted
    case onGoing
    case finishedSuccess
    case finishedSuccessEmpty
    case finishedFailed
}

/// Filenames
enum File {
    static let searchResponse = "SearchResponse"
}
