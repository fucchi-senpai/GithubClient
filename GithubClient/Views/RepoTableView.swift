//
//  RepoTableView.swift
//  GithubClient
//
//  Created by Shota Fuchikami on 2021/06/05.
//

import UIKit

protocol RepoTableViewDelegate: AnyObject {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
}

class RepoTableView: UIView {
    
    weak var delegate: RepoTableViewDelegate?
    
    private let tableView = UITableView()
    
    override func layoutSubviews() {
        self.initView()
    }
    
    deinit {
        print(#function)
    }
    
    private func initView() {
        self.addSubview(tableView)
        tableView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        tableView.delegate = self
        tableView.dataSource = self
    }

}

extension RepoTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return delegate?.tableView(tableView, numberOfRowsInSection: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return delegate?.tableView(tableView, cellForRowAt: indexPath) ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.tableView(tableView, didSelectRowAt: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.frame.width / 4.5
    }
}
