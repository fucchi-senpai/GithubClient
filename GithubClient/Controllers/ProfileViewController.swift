//
//  ProfileViewController.swift
//  GithubClient
//
//  Created by Shota Fuchikami on 2021/06/07.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private var profileView: ProfileView?
    
    init(profileView: ProfileView) {
        self.profileView = profileView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print(#function)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNavigationView()
        initProfileView()
    }
    
    private func initNavigationView() {
        self.navigationItem.title = Const.NavigationTitle.profilePage
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationItem.largeTitleDisplayMode = .always
    }
    
    private func initProfileView() {
        guard let profileView = profileView else { return }
        self.view.addSubview(profileView)
        profileView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profileView.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.4),
            profileView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            profileView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 16.0),
            profileView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
    }

}
