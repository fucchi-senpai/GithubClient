//
//  RepoViewController.swift
//  GithubClient
//
//  Created by Shota Fuchikami on 2021/06/05.
//

import UIKit

class RepoViewController: BaseViewController {
    
    private var githubModel: GithubModel?
    private var tableView: RepoTableView?
    
    var reposDataList: [Repos] = []
    
    init(tableView: RepoTableView, githubModel: GithubModel) {
        self.tableView = tableView
        self.githubModel = githubModel
        super.init(loadingView: LoadingView(), requestUrl: "https://api.github.com/users/fucchi-senpai/repos")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        self.delegate = self
        super.viewDidLoad()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: Const.CellReuseIdentifier.repoCellView) ?? RepoTableViewCell(cellData: CellData(profileImageUrl: repos.owner.avatarUrl, ownerName: repos.owner.loginName ?? "No Owner Name", repositoryName: repos.name ?? "No Repos Name"))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repos = self.reposDataList[indexPath.row]
        let userData = CellData(profileImageUrl: repos.owner.avatarUrl, ownerName: repos.owner.loginName ?? "No Owner Name", repositoryName: repos.name ?? "No Repos Name", aboutRepository: repos.description ?? "", starCount: String(repos.stargazersCount))
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
