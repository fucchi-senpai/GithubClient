//
//  RepoDetailView.swift
//  GithubClient
//
//  Created by Shota Fuchikami on 2021/06/06.
//

import UIKit

class RepoDetailView: UIView {

    private let stackView = UIStackView()
    
    private let userStackView = UIStackView()
    private let profileImageView = UIImageView()
    private let ownerName = UILabel()
    
    private let repositoryName = UILabel()

    private let aboutRepository = UILabel()

    private let starStackView = UIStackView()
    private let starImageView = UIImageView()
    private let countStar = UILabel()
    
    private var userData: CellData
    
    required init(userData: CellData) {
        self.userData = userData
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print(#function)
    }
    
    override func layoutSubviews() {
        refresh()
    }
    
    func refresh() {
        initStackView()
        initUserStackView()
        initProfileImageView()
        initOwnerName()
        initRepositoryName()
        initAboutRepository()
        initStarStackView()
        initStarImageView()
        initCountStar()
    }
    
    private func initStackView() {
        self.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(userStackView)
        stackView.addArrangedSubview(repositoryName)
        stackView.addArrangedSubview(aboutRepository)
        stackView.addArrangedSubview(starStackView)
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .leading
        NSLayoutConstraint.activate([
            stackView.heightAnchor.constraint(equalTo: heightAnchor),
            stackView.widthAnchor.constraint(equalTo: widthAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    private func initUserStackView() {
        userStackView.translatesAutoresizingMaskIntoConstraints = false
        userStackView.addArrangedSubview(profileImageView)
        userStackView.addArrangedSubview(ownerName)
        userStackView.axis = .horizontal
        userStackView.alignment = .center
    }
    
    private func initProfileImageView() {
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        if let profileImageData = self.userData.profileImageData {
            profileImageView.image = UIImage(data: profileImageData)
        } else {
            profileImageView.image = UIImage(named: Const.AssetsName.githubMark)
        }
        NSLayoutConstraint.activate([
            profileImageView.heightAnchor.constraint(equalTo: userStackView.heightAnchor, multiplier: 0.5),
            profileImageView.widthAnchor.constraint(equalTo: userStackView.widthAnchor, multiplier: 0.2)
        ])
    }
    
    private func initOwnerName() {
        ownerName.translatesAutoresizingMaskIntoConstraints = false
        ownerName.text = self.userData.ownerName
        ownerName.font = UIFont.systemFont(ofSize: 12.0)
    }
    
    private func initRepositoryName() {
        repositoryName.translatesAutoresizingMaskIntoConstraints = false
        repositoryName.text = self.userData.repositoryName
        repositoryName.font = UIFont.boldSystemFont(ofSize: 20.0)
    }
    
    private func initAboutRepository() {
        aboutRepository.translatesAutoresizingMaskIntoConstraints = false
        aboutRepository.text = self.userData.aboutRepository
        aboutRepository.font = UIFont.systemFont(ofSize: 16.0)
    }
    
    private func initStarStackView() {
        starStackView.translatesAutoresizingMaskIntoConstraints = false
        starStackView.addArrangedSubview(starImageView)
        starStackView.addArrangedSubview(countStar)
        starStackView.axis = .horizontal
    }
    
    private func initStarImageView() {
        starImageView.translatesAutoresizingMaskIntoConstraints = false
        starImageView.image = UIImage(systemName: "star")
        starImageView.tintColor = .systemGray
        NSLayoutConstraint.activate([
            starImageView.widthAnchor.constraint(equalTo: starStackView.widthAnchor, multiplier: 0.2)
        ])
    }
    
    private func initCountStar() {
        countStar.translatesAutoresizingMaskIntoConstraints = false
        countStar.text = "\(self.userData.starCount) stars"
        countStar.font = UIFont.systemFont(ofSize: 12.0)
    }
    
    
}
