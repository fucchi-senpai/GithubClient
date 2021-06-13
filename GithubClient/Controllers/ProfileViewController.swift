//
//  ProfileViewController.swift
//  GithubClient
//
//  Created by Shota Fuchikami on 2021/06/07.
//

import UIKit

class ProfileViewController: BaseViewController {
    
    private var githubModel: GithubModel?
    
    private var userData: UserEntity? = nil
    
    init(githubModel: GithubModel) {
        self.githubModel = githubModel
        super.init(loadingView: LoadingView(), requestUrl: "https://api.github.com/users/fucchi-senpai")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        self.delegate = self
        super.viewDidLoad()
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
    
}

extension ProfileViewController: BaseViewDelegate {
    
    func initViews() {
        self.initNavigationView()
        self.initProfileView()
    }
    
    func load(url: String, completion: @escaping (Data) -> Void) {
        let result = self.githubModel?.fetchGithub(requestUrl: url)
        self.subscription = result?.subscribe(onNext: { data in
            completion(data)
        }, onError: { error in
            print("error: \(error)")
            DispatchQueue.main.async {
                let action = UIAlertAction(title: Const.AlertContent.buttonLabel, style: .default, handler: nil)
                let content = AlertContent(title: Const.AlertContent.title, message: Const.AlertContent.message, action: action)
                UIAlertController.present(on: self, content)
            }
        })
    }
    
    func setUp(data: Data) {
        do {
            let user = try JSONDecoder().decode(User.self, from: data)
            self.userData = UserEntity(profileImageUrl: user.avatarUrl, name: user.name, bio: user.bio)
            print("decode success: \(String(describing: self.userData))")
        } catch let err {
            print("error: \(err)")
        }
    }
    
}
