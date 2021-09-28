//
//  Repository.swift
//  Github_Repo_Search_Directpl
//
//  Created by Joyce on 9/27/21.
//

import Foundation
import  SwiftyJSON

struct Repository: Decodable {
    let id: Int
    let name: String?
    let description: String?
    let url: String?
    let starCount: Int?
    let forkCount: Int?
    let owner: Owner?
    
    init(json: JSON) {
        self.id = json[RepositoryKey.id].intValue
        self.name = json[RepositoryKey.name].string
        self.description = json[RepositoryKey.description].string
        self.url = json[RepositoryKey.htmlUrl].string
        self.starCount = json[RepositoryKey.starCount].int
        self.forkCount = json[RepositoryKey.forkCount].int
        self.owner = Owner(json: json[RepositoryKey.owner])
    }
}
