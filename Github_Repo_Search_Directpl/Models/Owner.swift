//
//  Owner.swift
//  Github_Repo_Search_Directpl
//
//  Created by Joyce on 9/27/21.
//

import Foundation
import  SwiftyJSON

struct Owner: Decodable {
    let id: Int
    let name: String?
    let avatarUrl: String?
    
    init(json: JSON) {
        self.id = json[OwnerKey.id].intValue
        self.name = json[OwnerKey.name].string
        self.avatarUrl = json[OwnerKey.avatarUrl].string
    }
}
