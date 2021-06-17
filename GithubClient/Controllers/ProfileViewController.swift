//
//  ProfileViewController.swift
//  GithubClient
//
//  Created by Shota Fuchikami on 2021/06/07.
//

import UIKit
import RxSwift

class ProfileViewController: UIViewController {
    
    // MARK: field variable
    var userData: UserEntity? = nil
    
    private(set) weak var delegate: BaseViewDelegate?
    private var githubModel: GithubModel?
    private var subscription: Disposable?
    private var loadingView: LoadingView?
    
    init(githubModel: GithubModel, loadingView: LoadingView) {
        self.githubModel = githubModel
        self.loadingView = loadingView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print(#function)
    }
    
    // MARK: Life cycle function
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.beforeLoad()
        self.delegate?.load(url: "https://api.github.com/users/fucchi-senpai") { data in
            self.delegate?.setUp(data: data)
            self.postLoad()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.subscription?.dispose()
    }
    
    // MARK: Private function
    /// API読み込み前処理
    private func beforeLoad() {
        print(#function)
        DispatchQueue.main.async {
            self.view.backgroundColor = .systemBackground
            self.initLoadingView()
            self.loadingView?.start()
        }
    }
    
    /// API読み込み後処理
    private func postLoad() {
        print(#function)
        DispatchQueue.main.async {
            self.delegate?.initViews()
            self.loadingView?.stop()
        }
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
    
    func initLoadingView() {
        guard let loadingView = self.loadingView else { return }
        self.view.addSubview(loadingView)
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadingView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.2),
            loadingView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.2),
            loadingView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            loadingView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
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
