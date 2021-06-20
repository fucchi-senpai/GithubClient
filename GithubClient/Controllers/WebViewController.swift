//
//  WebViewController.swift
//  GithubClient
//
//  Created by Shota Fuchikami on 2021/06/20.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKUIDelegate {
    
    private var webView: WKWebView?
    private var url: String?
    
    init(url: String) {
        self.url = url
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
        initWebView()
        let myURL = URL(string: self.url ?? "")
        let myRequest = URLRequest(url: myURL!)
        webView?.load(myRequest)
    }
    
    private func initWebView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        guard let webView = self.webView else { return }
        self.view.addSubview(webView)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        webView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            webView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            webView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            webView.rightAnchor.constraint(equalTo: self.view.rightAnchor)
        ])
    }

}

extension WebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url
        print("callback url: \(String(describing: url))")
        if url?.scheme == "githubclient", url?.host == "oauth" {
            // TODO: Not implementation
        }
        decisionHandler(WKNavigationActionPolicy.allow)
    }
}
