//
//  SearchViewModel.swift
//  Github_Repo_Search_Directpl
//
//  Created by Joyce on 9/27/21.
//

import Foundation
import Alamofire

class SearchViewModel: NSObject {
    var adapter: NetworkService!
    var repositories: Repositories?
    var keyword: String? = "swift"
    
    init(adapter: Networkable = NetworkService()) {
        self.adapter = adapter as? NetworkService
    }
    
}

// MARK: Public Functions
extension SearchViewModel {
    
    func searchRepositories(completion: @escaping repositoriesCompletionBlock,
        errorCompletion: @escaping errorCompletionBlock,
        failed: @escaping failedBlock) {
        guard let _ = keyword else { return }
        self.adapter.searchRepositories(
            keyword: keyword!,
            completion: { [weak self] response in
                self?.repositories = response
                completion(response)
            }, errorCompletion: { error in
                errorCompletion(error)
            }, failed: { error in
                failed(error)
            })
    }
    
    func cancelRequests() {
        Alamofire.Session.default.session.getTasksWithCompletionHandler({ dataTasks, uploadTasks, downloadTasks in
                    dataTasks.forEach { $0.cancel() }
                    uploadTasks.forEach { $0.cancel() }
                    downloadTasks.forEach { $0.cancel() }
                })
    }
}
