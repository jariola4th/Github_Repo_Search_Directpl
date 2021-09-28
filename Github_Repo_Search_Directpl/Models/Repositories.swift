//
//  Repositories.swift
//  Github_Repo_Search_Directpl
//
//  Created by Joyce on 9/27/21.
//

import Foundation
import SwiftyJSON

class Repositories {
    private var repositories: Array<Repository>?
    
    init(json: JSON) {
        setItems(json: json)
    }
}

// MARK: Public Functions
extension Repositories {

    func count() -> Int {
        guard let _ = repositories else {
            return 0
        }
        return repositories!.count
    }

    func itemAtIndex(_ index: Int) -> Repository? {
        guard let _ = repositories else {
            return nil
        }
        if repositories!.count < 1 {
            return nil
        }
        return repositories![index]
    }

     func clear() {
        guard let _ = repositories as Array<Repository>? else {
            return
        }
        repositories?.removeAll()
    }
}

// MARK: Private Functions
extension Repositories {
    private func setItems(json: JSON) {
        if json.count < 1 {
            return
        }

        self.repositories = Array<Repository>()
        for item in json.arrayValue {
            let repository: Repository! = Repository(json: item)
            repositories?.append(repository)
        }
    }
}

