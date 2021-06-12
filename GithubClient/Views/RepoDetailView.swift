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
    private let starNumber = UILabel()
    private let starUnitLabel = UILabel()
    
    private let webViewLinkLabel = UITextView()
    
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
        initStarNumber()
        initStarUnitLabel()
        initWebViewLinkLabel()
    }
    
    private func initStackView() {
        self.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(userStackView)
        stackView.addArrangedSubview(repositoryName)
        stackView.addArrangedSubview(aboutRepository)
        stackView.addArrangedSubview(starStackView)
        stackView.addArrangedSubview(webViewLinkLabel)
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .leading
        stackView.spacing = 8
        NSLayoutConstraint.activate([
            stackView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.9),
            stackView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9),
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
        userStackView.spacing = 8
    }
    
    private func initProfileImageView() {
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        if let url = self.userData.profileImageUrl {
            profileImageView.image = UIImage.load(url: url)
        } else {
            profileImageView.image = UIImage(named: Const.AssetsName.githubMark)
        }
        NSLayoutConstraint.activate([
            profileImageView.widthAnchor.constraint(equalTo: userStackView.widthAnchor, multiplier: 0.11)
        ])
    }
    
    private func initOwnerName() {
        ownerName.translatesAutoresizingMaskIntoConstraints = false
        ownerName.text = self.userData.ownerName
        ownerName.font = UIFont.systemFont(ofSize: 12.0)
        ownerName.lineBreakMode = .byTruncatingTail
    }
    
    private func initRepositoryName() {
        repositoryName.translatesAutoresizingMaskIntoConstraints = false
        repositoryName.text = self.userData.repositoryName
        repositoryName.font = UIFont.boldSystemFont(ofSize: 20.0)
        repositoryName.lineBreakMode = .byTruncatingTail
    }
    
    private func initAboutRepository() {
        aboutRepository.translatesAutoresizingMaskIntoConstraints = false
        aboutRepository.text = self.userData.aboutRepository
        aboutRepository.font = UIFont.systemFont(ofSize: 16.0)
        aboutRepository.lineBreakMode = .byTruncatingTail
    }
    
    private func initStarStackView() {
        starStackView.translatesAutoresizingMaskIntoConstraints = false
        starStackView.addArrangedSubview(starImageView)
        starStackView.addArrangedSubview(starNumber)
        starStackView.addArrangedSubview(starUnitLabel)
        starStackView.axis = .horizontal
        starStackView.alignment = .center
        starStackView.spacing = 4
    }
    
    private func initStarImageView() {
        starImageView.translatesAutoresizingMaskIntoConstraints = false
        starImageView.image = UIImage(systemName: "star")
        starImageView.tintColor = .systemGray
        NSLayoutConstraint.activate([
            starImageView.widthAnchor.constraint(equalToConstant: 22)
        ])
    }
    
    private func initStarNumber() {
        starNumber.translatesAutoresizingMaskIntoConstraints = false
        starNumber.text = self.userData.starCount
        starNumber.font = UIFont.systemFont(ofSize: 12.0)
        starNumber.lineBreakMode = .byTruncatingTail
        NSLayoutConstraint.activate([
            starNumber.widthAnchor.constraint(lessThanOrEqualTo: starStackView.widthAnchor, multiplier: 0.8)
        ])
    }
    
    private func initStarUnitLabel() {
        starUnitLabel.translatesAutoresizingMaskIntoConstraints = false
        starUnitLabel.text = "stars"
        starUnitLabel.font = UIFont.systemFont(ofSize: 12.0)
    }
    
    private func initWebViewLinkLabel() {
        webViewLinkLabel.translatesAutoresizingMaskIntoConstraints = false
        webViewLinkLabel.isSelectable = true
        webViewLinkLabel.isEditable = false
        let text = "See Code on Github"
        let attribute = NSMutableAttributedString(string: text)
        let range = NSString(string: text).range(of: text)
        attribute.addAttribute(.link, value: "https://github.com/fucchi-senpai/GithubClient", range: range)
        webViewLinkLabel.attributedText = attribute
        NSLayoutConstraint.activate([
            webViewLinkLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor)
        ])
    }
    
}
