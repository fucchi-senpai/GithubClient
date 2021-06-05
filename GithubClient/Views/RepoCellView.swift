//
//  RepoCellView.swift
//  GithubClient
//
//  Created by Shota Fuchikami on 2021/06/05.
//

import UIKit

class RepoCellView: UIView {

    private let tableViewCell = UITableViewCell(style: .default, reuseIdentifier: "cell")
    private let stackView = UIStackView()
    private let textStackView = UIStackView()
    private let imageView = UIImageView()
    private let ownerLabel = UILabel()
    private let repoNameLabel = UILabel()
    
    private var label: String?
    
    private var cellData: CellData?
    
    init(cellData: CellData) {
        super.init(frame: .zero)
        self.cellData = cellData
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        refresh()
    }
    
    func refresh() {
        initCellView()
        initStackView()
        initTextStackView()
        initImageView()
        initOwnerNameLabel()
        initRepoNameLabel()
    }
    
    private func initCellView() {
        self.addSubview(tableViewCell)
        tableViewCell.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableViewCell.centerYAnchor.constraint(equalTo: centerYAnchor),
            tableViewCell.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    private func initStackView() {
        self.addSubview(stackView)
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(textStackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        NSLayoutConstraint.activate([
            stackView.widthAnchor.constraint(equalTo: widthAnchor),
            stackView.heightAnchor.constraint(equalTo: heightAnchor),
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
            textStackView.heightAnchor.constraint(equalTo: stackView.heightAnchor),
            textStackView.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.8),
            textStackView.topAnchor.constraint(equalTo: stackView.topAnchor),
            textStackView.rightAnchor.constraint(equalTo: stackView.rightAnchor),
            textStackView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor)
        ])
    }
    
    private func initImageView() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        if let imageData = cellData?.profileImageData {
            imageView.image = UIImage(data: imageData)
        } else {
            imageView.image = UIImage(systemName: "person.circle")
        }
        imageView.tintColor = .gray
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalTo: stackView.heightAnchor),
            imageView.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.2),
            imageView.topAnchor.constraint(equalTo: stackView.topAnchor),
            imageView.leftAnchor.constraint(equalTo: stackView.leftAnchor),
            imageView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor)
        ])
    }
    
    private func initOwnerNameLabel() {
        ownerLabel.translatesAutoresizingMaskIntoConstraints = false
        ownerLabel.text = cellData?.ownerName
        ownerLabel.tintColor = .systemFill
        ownerLabel.font = UIFont.systemFont(ofSize: 16.0)
        NSLayoutConstraint.activate([
            ownerLabel.heightAnchor.constraint(equalTo: textStackView.heightAnchor, multiplier: 0.4),
            ownerLabel.widthAnchor.constraint(equalTo: textStackView.widthAnchor),
            ownerLabel.topAnchor.constraint(equalTo: textStackView.topAnchor),
            ownerLabel.rightAnchor.constraint(equalTo: textStackView.rightAnchor),
            ownerLabel.bottomAnchor.constraint(equalTo: repoNameLabel.topAnchor)
        ])
    }
    
    private func initRepoNameLabel() {
        repoNameLabel.translatesAutoresizingMaskIntoConstraints = false
        repoNameLabel.text = cellData?.repositoryName
        repoNameLabel.tintColor = .systemFill
        repoNameLabel.font = UIFont.systemFont(ofSize: 24.0)
        NSLayoutConstraint.activate([
            repoNameLabel.heightAnchor.constraint(equalTo: textStackView.heightAnchor, multiplier: 0.6),
            repoNameLabel.widthAnchor.constraint(equalTo: textStackView.widthAnchor),
            repoNameLabel.topAnchor.constraint(equalTo: ownerLabel.bottomAnchor),
            repoNameLabel.rightAnchor.constraint(equalTo: textStackView.rightAnchor),
            repoNameLabel.bottomAnchor.constraint(equalTo: textStackView.bottomAnchor)
        ])
    }
}
