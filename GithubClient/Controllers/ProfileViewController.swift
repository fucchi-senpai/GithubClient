//
//  ProfileViewController.swift
//  GithubClient
//
//  Created by Shota Fuchikami on 2021/06/07.
//

import UIKit
import RxSwift

class ProfileViewController: UIViewController {
    
    private var githubModel: GithubModel?
    private var userData: UserEntity? = nil
    private var subscription: Disposable? = nil
    
    init(githubModel: GithubModel) {
        self.githubModel = githubModel
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
        loadUser {
            DispatchQueue.main.async {
                self.initView()
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.subscription?.dispose()
    }
    
    private func initView() {
        view.backgroundColor = .systemBackground
        initNavigationView()
        initProfileView()
    }
    
    private func initNavigationView() {
        self.navigationItem.title = Const.NavigationTitle.profilePage
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationItem.largeTitleDisplayMode = .always
    }
    
    private func initProfileView() {
        guard let userData = self.userData else { return }
        let profileView = ProfileView(userData: userData)
        self.view.addSubview(profileView)
        profileView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profileView.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.4),
            profileView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            profileView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 16.0),
            profileView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
    }
    
    private func loadUser(completion: @escaping () -> Void) {
        let result = self.githubModel?.fetchGithub(requestUrl: "https://api.github.com/users/fucchi-senpai")
        self.subscription = result?.subscribe(onNext: { data in
            self.setUp(user: data)
            completion()
        })
    }
    
    private func setUp(user: Data) {
        do {
            let data = try JSONDecoder().decode(User.self, from: user)
            self.userData = UserEntity(profileImageUrl: data.avatarUrl, name: data.name, bio: data.bio)
            print("decode success: \(String(describing: self.userData))")
        } catch let err {
            print("error: \(err)")
        }
    }

}
