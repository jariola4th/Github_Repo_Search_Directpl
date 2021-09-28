//
//  SearchViewController.swift
//  Github_Repo_Search_Directpl
//
//  Created by Joyce on 9/27/21.
//

import UIKit

class SearchViewController: UIViewController, Storyboarded {
    
    weak var coordinator: MainCoordinator?
    @IBOutlet var searchView: SearchView!
    lazy var searchViewModel: SearchViewModel = SearchViewModel()
    var searchTask: DispatchWorkItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegates()
        searchView.initView()
    }

}

// MARK: UITableViewDelegate, UITableViewDataSource
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchViewModel.repositories?.count() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = searchView.tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as! SearchTableViewCell
        let repository = searchViewModel.repositories?.itemAtIndex(indexPath.row)
        cell.configure(with: repository)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repository = searchViewModel.repositories?.itemAtIndex(indexPath.row)
        openBrower(with: URL(string: repository?.url ?? ""))
    }
}

// MARK: SearchViewDelegate
extension SearchViewController: SearchViewDelegate {
    
    func didChangeTextFieldInView(_ view: SearchView, with text: String?) {
        searchViewModel.keyword = text
        cancelRequests()
        startSearchTask()
    }
    
    func didPressClearButtonInView(_ view: SearchView) {
        searchViewModel.keyword = ""
        searchViewModel.repositories = nil
        searchView.tableView.reloadData()
        cancelRequests()
    }
    
}

// MARK: Private Functions
extension SearchViewController {
    
    private func setupDelegates() {
        searchView.delegate = self
        searchView.tableView.delegate = self
        searchView.tableView.dataSource = self
    }
    
    private func search() {
        searchView.status = .onGoing
        searchViewModel.searchRepositories(
            completion: { [weak self] response in
                self?.searchView.tableView.reloadData()
                if response.count() < 1 {
                    self?.searchView.status = .finishedSuccessEmpty
                } else {
                    self?.searchView.status = .finishedSuccess
                }
            }, errorCompletion: { [weak self] error in
                self?.searchView.tableView.reloadData()
                self?.searchView.status = .finishedFailed
                print(error)
            }, failed: { [weak self] error in
                self?.searchView.tableView.reloadData()
                self?.searchView.status = .finishedFailed
                print(error)
            })
    }
    
    private func cancelRequests() {
        searchTask?.cancel()
        searchViewModel.cancelRequests()
    }
    
    private func startSearchTask() {
        let task = DispatchWorkItem { [weak self] in
            self?.search()
        }
        searchTask = task
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.75, execute: task)
    }
    
    private func openBrower(with url: URL?) {
        if let _ = url {
            UIApplication.shared.open(url!)
        }
    }
    
}

