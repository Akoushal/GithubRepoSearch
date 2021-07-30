//
//  RepositoryTableViewCell.swift
//  GithubRepoSearch
//
//  Created by Koushal, Kumar Ajitesh | Ajitesh | TDD on 2021/07/28.
//

import UIKit

class RepositoryTableViewCell: UITableViewCell {
    
    static let LeadingAnchorConstant: CGFloat = 25
    static let TrailingAnchorConstant: CGFloat = 50
    static let TopAnchorConstant: CGFloat = 25
    static let BottomAnchorConstant: CGFloat = 25
    static let HeightConstant: CGFloat = 25
    
    lazy var repositoryName: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.boldSystemFont(ofSize: Constants.TitleFont)
        return lbl
    }()
    
    lazy var repositoryLastUpdateLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.boldSystemFont(ofSize: Constants.SubtitleFont)
        return lbl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // Add the UI components
        contentView.addSubview(repositoryName)
        contentView.addSubview(repositoryLastUpdateLabel)
        
        NSLayoutConstraint.activate([
            repositoryName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: RepositoryTableViewCell.LeadingAnchorConstant),
            repositoryName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: RepositoryTableViewCell.TopAnchorConstant),
            repositoryName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -RepositoryTableViewCell.TrailingAnchorConstant),
            repositoryName.heightAnchor.constraint(equalToConstant: RepositoryTableViewCell.HeightConstant)
        ])
        
        NSLayoutConstraint.activate([
            repositoryLastUpdateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: RepositoryTableViewCell.LeadingAnchorConstant),
            repositoryLastUpdateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -RepositoryTableViewCell.TrailingAnchorConstant),
            repositoryLastUpdateLabel.topAnchor.constraint(equalTo: repositoryName.bottomAnchor, constant: RepositoryTableViewCell.TopAnchorConstant),
            repositoryLastUpdateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -RepositoryTableViewCell.BottomAnchorConstant)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with repository: Repository?) {
        if let repository = repository,
           let lastUpdatedAt = repository.updatedAt {
            repositoryName.text = repository.name
            repositoryLastUpdateLabel.text = "Last updated at: \(DateFormatter.string(iso: lastUpdatedAt))"
        }
    }
}
