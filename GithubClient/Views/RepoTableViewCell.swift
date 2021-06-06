//
//  RepoTableViewCell.swift
//  GithubClient
//
//  Created by Shota Fuchikami on 2021/06/05.
//

import UIKit

class RepoTableViewCell: UITableViewCell {

    private let stackView = UIStackView()
    private let textStackView = UIStackView()
    private let profileImageView = UIImageView()
    private let ownerLabel = UILabel()
    private let repoNameLabel = UILabel()
    
    private var label: String?
    
    private var cellData: CellData
    
    init(cellData: CellData) {
        self.cellData = cellData
        super.init(style: .default, reuseIdentifier: "repoCellView")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        refresh()
    }
    
    func refresh() {
        initStackView()
        initTextStackView()
        initImageView()
        initOwnerNameLabel()
        initRepoNameLabel()
    }
    
    
    private func initStackView() {
        self.addSubview(stackView)
        stackView.addArrangedSubview(profileImageView)
        stackView.addArrangedSubview(textStackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        NSLayoutConstraint.activate([
            stackView.widthAnchor.constraint(equalTo: widthAnchor),
            stackView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.95),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    private func initTextStackView() {
        textStackView.addArrangedSubview(ownerLabel)
        textStackView.addArrangedSubview(repoNameLabel)
        textStackView.translatesAutoresizingMaskIntoConstraints = false
        textStackView.axis = .vertical
        NSLayoutConstraint.activate([
            textStackView.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.8),
            textStackView.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 16),
            textStackView.centerYAnchor.constraint(equalTo: stackView.centerYAnchor)
        ])
    }
    
    private func initImageView() {
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        if let imageData = cellData.profileImageData {
            profileImageView.image = UIImage(data: imageData)
        } else {
            profileImageView.image = UIImage(systemName: "person.circle")
        }
        profileImageView.tintColor = .gray
        NSLayoutConstraint.activate([
            profileImageView.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.2),
            profileImageView.centerYAnchor.constraint(equalTo: stackView.centerYAnchor),
        ])
    }
    
    private func initOwnerNameLabel() {
        ownerLabel.translatesAutoresizingMaskIntoConstraints = false
        ownerLabel.text = "owner: \(cellData.ownerName)"
        ownerLabel.tintColor = .systemFill
        ownerLabel.font = UIFont.systemFont(ofSize: 14.0)
        ownerLabel.numberOfLines = 1
        ownerLabel.lineBreakMode = .byTruncatingTail
        NSLayoutConstraint.activate([
            ownerLabel.heightAnchor.constraint(equalTo: textStackView.heightAnchor, multiplier: 0.4),
            ownerLabel.widthAnchor.constraint(equalTo: textStackView.widthAnchor),
            ownerLabel.topAnchor.constraint(equalTo: textStackView.topAnchor),
            ownerLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 16),
            ownerLabel.rightAnchor.constraint(equalTo: textStackView.rightAnchor),
            ownerLabel.bottomAnchor.constraint(equalTo: repoNameLabel.topAnchor)
        ])
    }
    
    private func initRepoNameLabel() {
        repoNameLabel.translatesAutoresizingMaskIntoConstraints = false
        repoNameLabel.text = cellData.repositoryName
        repoNameLabel.tintColor = .systemFill
        repoNameLabel.font = UIFont.systemFont(ofSize: 20.0)
        repoNameLabel.numberOfLines = 1
        repoNameLabel.lineBreakMode = .byTruncatingTail
        NSLayoutConstraint.activate([
            repoNameLabel.heightAnchor.constraint(equalTo: textStackView.heightAnchor, multiplier: 0.6),
            repoNameLabel.widthAnchor.constraint(equalTo: textStackView.widthAnchor),
            repoNameLabel.topAnchor.constraint(equalTo: ownerLabel.bottomAnchor),
            repoNameLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 16),
            repoNameLabel.rightAnchor.constraint(equalTo: rightAnchor),
            repoNameLabel.bottomAnchor.constraint(equalTo: textStackView.bottomAnchor)
        ])
    }
}
