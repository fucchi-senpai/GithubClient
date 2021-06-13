//
//  BaseViewController.swift
//  GithubClient
//
//  Created by Shota Fuchikami on 2021/06/13.
//

import UIKit
import RxSwift

protocol BaseViewDelegate: AnyObject {
    /// initialize views
    func initViews()
    /// load API
    /// - Parameters:
    ///   - url: requestURLl
    ///   - completion: completion behavior
    func load(url: String, completion: @escaping (Data) -> Void)
    /// set up data from API
    /// - Parameter data: data from API
    func setUp(data: Data)
}

/// Base View for Tab Item views
open class BaseViewController: UIViewController {
    
    // MARK: field variable
    weak var delegate: BaseViewDelegate?
    var subscription: Disposable?
    private var loadingView: LoadingView?
    private var requestUrl: String?
    
    // MARK: initializer
    init(loadingView: LoadingView, requestUrl: String) {
        print(#function)
        self.loadingView = loadingView
        self.requestUrl = requestUrl
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print(#function)
    }
    
    // MARK: Life cycle function
    open override func viewDidLoad() {
        print(#function)
        super.viewDidLoad()
        self.beforeLoad()
        self.delegate?.load(url: self.requestUrl ?? "") { data in
            self.delegate?.setUp(data: data)
            self.postLoad()
        }
    }
    
    open override func viewDidDisappear(_ animated: Bool) {
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

}
