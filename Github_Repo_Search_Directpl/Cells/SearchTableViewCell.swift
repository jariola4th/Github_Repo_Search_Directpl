//
//  SearchTableViewCell.swift
//  Github_Repo_Search_Directpl
//
//  Created by Joyce on 9/27/21.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    static let identifier = "SearchTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var stargazersCountLabel: UILabel!
    @IBOutlet weak var forksCountLabel: UILabel!
    @IBOutlet weak var ownerAvatarImageView: UIImageView!
    @IBOutlet weak var ownerLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0))
    }
    
}

// MARK: Public Functions
extension SearchTableViewCell {
    
    func configure(with repository: Repository?) {
        if let _ = repository {
            titleLabel.text = repository?.name
            descriptionLabel.text = repository?.description
            stargazersCountLabel.text = "\(repository?.starCount ?? 0)"
            forksCountLabel.text = "\(repository?.forkCount ?? 0)"
            ownerLabel.text = repository?.owner?.name
            guard let imageURL = URL(string: repository?.owner?.avatarUrl ?? "") else {
                return
            }
            ownerAvatarImageView.load(url: imageURL)
        } else {
            titleLabel.text = ""
            descriptionLabel.text = ""
            stargazersCountLabel.text = ""
            forksCountLabel.text = ""
            ownerAvatarImageView.image = nil
            ownerLabel.text = ""
        }
    }
}
