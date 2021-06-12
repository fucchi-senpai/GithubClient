//
//  RepoTableViewCell.swift
//  GithubClient
//
//  Created by Shota Fuchikami on 2021/06/05.
//

import UIKit

class RepoTableViewCell: UITableViewCell {

    private let separator = UIView()
    private let stackView = UIStackView()
    private let textStackView = UIStackView()
    private let profileImageView = UIImageView()
    private let ownerLabel = UILabel()
    private let repoNameLabel = UILabel()
    
    private var cellData: CellData
    
    init(cellData: CellData) {
        self.cellData = cellData
        super.init(style: .default, reuseIdentifier: Const.CellReuseIdentifier.repoCellView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        refresh()
    }
    
    func refresh() {
        initSeparator()
        initStackView()
        initTextStackView()
        initProfileImageView()
        initOwnerNameLabel()
        initRepoNameLabel()
    }
    
    private func initSeparator() {
        self.addSubview(separator)
        separator.backgroundColor = .systemFill
        separator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            separator.heightAnchor.constraint(equalToConstant: 1),
            separator.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.95),
            separator.bottomAnchor.constraint(equalTo: bottomAnchor),
            separator.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    
    private func initStackView() {
        self.addSubview(stackView)
        stackView.addArrangedSubview(profileImageView)
        stackView.addArrangedSubview(textStackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 16
        NSLayoutConstraint.activate([
            stackView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.95),
            stackView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.9),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    private func initTextStackView() {
        textStackView.addArrangedSubview(ownerLabel)
        textStackView.addArrangedSubview(repoNameLabel)
        textStackView.translatesAutoresizingMaskIntoConstraints = false
        textStackView.axis = .vertical
        textStackView.distribution = .fillProportionally
        NSLayoutConstraint.activate([
            textStackView.heightAnchor.constraint(equalTo: stackView.heightAnchor),
        ])
    }
    
    private func initProfileImageView() {
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        if let url = cellData.profileImageUrl {
            profileImageView.image = UIImage.load(url: url)
        } else {
            profileImageView.image = UIImage(named: Const.AssetsName.githubMark)
        }
        profileImageView.tintColor = .systemGray
        NSLayoutConstraint.activate([
            profileImageView.heightAnchor.constraint(equalTo: stackView.heightAnchor),
            profileImageView.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.2),
        ])
    }
    
    private func initOwnerNameLabel() {
        ownerLabel.translatesAutoresizingMaskIntoConstraints = false
        ownerLabel.text = "owner: \(cellData.ownerName)"
        ownerLabel.tintColor = .systemFill
        ownerLabel.font = UIFont.systemFont(ofSize: 16.0)
        ownerLabel.numberOfLines = 1
        ownerLabel.lineBreakMode = .byTruncatingTail
    }
    
    private func initRepoNameLabel() {
        repoNameLabel.translatesAutoresizingMaskIntoConstraints = false
        repoNameLabel.text = cellData.repositoryName
        repoNameLabel.tintColor = .systemFill
        repoNameLabel.font = UIFont.boldSystemFont(ofSize: 24.0)
        repoNameLabel.numberOfLines = 1
        repoNameLabel.lineBreakMode = .byTruncatingTail
    }
}
