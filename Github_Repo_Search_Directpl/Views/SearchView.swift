//
//  SearchView.swift
//  Github_Repo_Search_Directpl
//
//  Created by Joyce on 9/27/21.
//

import UIKit

protocol SearchViewDelegate: AnyObject {
    func didChangeTextFieldInView(_ view: SearchView, with text: String?)
    func didPressClearButtonInView(_ view: SearchView)
}

class SearchView: UIView {
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var clearSearchButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var statusLabel: UILabel!
    
    weak var delegate: SearchViewDelegate?
    
    private var _status: FetchStatus = .notStarted
    var status: FetchStatus {
        set {
            _status = newValue
            setStatusLabel(with: newValue)
        } get { return _status }
    }
    
    @IBAction func textFieldDidChange(_ sender: UITextField) {
        clearSearchButton.isHidden = !shouldEnableClearButton()
        delegate?.didChangeTextFieldInView(self, with: searchTextField.text)
    }
    
    @IBAction func clearButtonPressed(_ sender: UIButton) {
        clearSearchKeyword()
        delegate?.didPressClearButtonInView(self)
    }
    
}

// MARK: Public Functions
extension SearchView {
    
    func initView() {
        initTableView()
        clearSearchButton.isHidden = true
        statusLabel.text = ""
        tableView.keyboardDismissMode = .interactive
    }
    
}

// MARK: Private Functions
extension SearchView {
    
    private func initTableView() {
        tableView.register(SearchTableViewCell.nib(), forCellReuseIdentifier: SearchTableViewCell.identifier)
    }
    
    private func shouldEnableClearButton() -> Bool {
        guard let _ = searchTextField.text else {
            return false
        }
        return searchTextField.text!.count > 0
    }
    
    private func clearSearchKeyword() {
        searchTextField.text = ""
        clearSearchButton.isHidden = true
    }
    
    private func setStatusLabel(with status: FetchStatus) {
        self.statusLabel.alpha = 1
        switch status {
        case .notStarted:
            self.statusLabel.isHidden = true
            statusLabel.text = ""
        case .onGoing:
            self.statusLabel.isHidden = false
            statusLabel.text = Message.networkOnGoing
        case .finishedSuccess:
            self.statusLabel.isHidden = false
            statusLabel.text = Message.networkSuccess
            UIView.transition(
                with: statusLabel,
                duration: 3,
                options: .allowUserInteraction,
                animations: { [weak self] in
                    self?.statusLabel.alpha = 0
                },
                completion: nil)
        case .finishedSuccessEmpty:
            self.statusLabel.isHidden = false
            statusLabel.text = Message.networkSuccessEmpty
        case .finishedFailed:
            self.statusLabel.isHidden = false
            statusLabel.text = Message.networkFailed
        }
    }
}
