//
//  RepoViewController.swift
//  GithubClient
//
//  Created by Shota Fuchikami on 2021/06/05.
//

import UIKit
import RxSwift

class RepoViewController: UIViewController {
    
    // MARK: field variable
    var reposDataList: [Repos] = []
    
    private(set) weak var delegate: BaseViewDelegate?
    private var githubModel: GithubModel?
    private var loadingView: LoadingView?
    private var subscription: Disposable?
    private var tableView: RepoTableView?
    
    init(tableView: RepoTableView, githubModel: GithubModel, loadingview: LoadingView) {
        self.tableView = tableView
        self.githubModel = githubModel
        self.loadingView = loadingview
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Life cycle function
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.beforeLoad()
        self.delegate?.load(url: "https://api.github.com/users/fucchi-senpai/repos") { data in
            self.delegate?.setUp(data: data)
            self.postLoad()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
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
    
    private func initLoadingView() {
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
    
    private func initNavigationView() {
        self.navigationItem.title = Const.NavigationTitle.repoPage
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationItem.largeTitleDisplayMode = .always
    }
    
    private func initTableView() {
        guard let repoTableView = tableView else { return }
        self.view.addSubview(repoTableView)
        repoTableView.delegate = self
        repoTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            repoTableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            repoTableView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            repoTableView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            repoTableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

}

extension RepoViewController: RepoTableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.reposDataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let repos = self.reposDataList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: Const.CellReuseIdentifier.repoCellView) ?? RepoTableViewCell(cellData: CellData(profileImageUrl: repos.owner.avatarUrl, ownerName: repos.owner.loginName, repositoryName: repos.name))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repos = self.reposDataList[indexPath.row]
        let userData = CellData(profileImageUrl: repos.owner.avatarUrl, ownerName: repos.owner.loginName, repositoryName: repos.name, aboutRepository: repos.description, starCount: String(repos.stargazersCount))
        let repoDetailView = RepoDetailView(userData: userData)
        self.navigationController?.pushViewController(RepoDetailViewController(repoDetailView: repoDetailView, navigationTitle: userData.repositoryName), animated: true)
    }
    
}

extension RepoViewController: BaseViewDelegate {
    
    func initViews() {
        self.initNavigationView()
        self.initTableView()
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
            let reposList = try JSONDecoder().decode([Repos].self, from: data)
            for repos in reposList {
                self.reposDataList.append(repos)
            }
            print("decode success: \(String(describing: self.reposDataList))")
        } catch let err {
            print("error: \(err)")
        }
    }
    
}
