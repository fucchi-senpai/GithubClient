//
//  ProfileView.swift
//  GithubClient
//
//  Created by Shota Fuchikami on 2021/06/07.
//

import UIKit

class ProfileView: UIView {
    
    private var vStackView = UIStackView()
    private var hStackView = UIStackView()
    private var profileImageView = UIImageView()
    private var userName = UILabel()
    private var bio = UILabel()
    
    // TODO: CellDataはリポジトリリスト用データのため変更する
    private var userData: UserEntity
    
    init(userData: UserEntity) {
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
        initVStackView()
        initHStackView()
        initProfileImageView()
        initUserName()
        initBio()
    }

    private func initVStackView() {
        self.addSubview(self.vStackView)
        vStackView.translatesAutoresizingMaskIntoConstraints = false
        vStackView.addArrangedSubview(hStackView)
        vStackView.addArrangedSubview(bio)
        vStackView.axis = .vertical
        vStackView.distribution = .fillEqually
        NSLayoutConstraint.activate([
            vStackView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.8),
            vStackView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
            vStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            vStackView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    private func initHStackView() {
        hStackView.addArrangedSubview(profileImageView)
        hStackView.addArrangedSubview(userName)
        hStackView.translatesAutoresizingMaskIntoConstraints = false
        hStackView.axis = .horizontal
        hStackView.alignment = .center
        hStackView.spacing = 16
    }
    
    private func initProfileImageView() {
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        if let url = self.userData.profileImageUrl {
            self.profileImageView.image = UIImage().load(url: url)
        } else {
            profileImageView.image = UIImage(named: Const.AssetsName.githubMark)
        }
        NSLayoutConstraint.activate([
            profileImageView.widthAnchor.constraint(equalTo: hStackView.widthAnchor, multiplier: 0.2)
        ])
    }
    
    private func initUserName() {
        userName.translatesAutoresizingMaskIntoConstraints = false
        userName.text = self.userData.name
        userName.font = UIFont.systemFont(ofSize: 16.0)
        userName.lineBreakMode = .byTruncatingTail
    }
    
    private func initBio() {
        bio.translatesAutoresizingMaskIntoConstraints = false
        bio.text = self.userData.bio ?? ""
        bio.font = UIFont.systemFont(ofSize: 12.0)
        bio.lineBreakMode = .byTruncatingTail
    }
}
