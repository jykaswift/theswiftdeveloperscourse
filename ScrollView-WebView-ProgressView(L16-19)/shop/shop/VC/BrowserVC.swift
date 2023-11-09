//
//  BrowserVC.swift
//  shop
//
//  Created by Евгений Борисов on 02.11.2023.
//

import UIKit
import WebKit

class BrowserVC: UIViewController {
    
    lazy var webView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()

    lazy var toolbarView = {
        let toolbar = UIView()
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        toolbar.backgroundColor = UIColor(red: 28, green: 28, blue: 30, alpha: 1)
        return toolbar
    }()
    
    lazy var rewindToolbarButton = {
        let rewindToolbarButton = UIButton()
        rewindToolbarButton.setImage(UIImage(systemName: "arrowshape.backward", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30)), for: .normal)
        rewindToolbarButton.translatesAutoresizingMaskIntoConstraints = false
        rewindToolbarButton.isEnabled = false
        return rewindToolbarButton
    }()
    
    lazy var forwardToolbarButton = {
        let forwardToolbarButton = UIButton()
        forwardToolbarButton.isEnabled = false
        forwardToolbarButton.setImage(UIImage(systemName: "arrowshape.forward", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30)), for: .normal)
        forwardToolbarButton.translatesAutoresizingMaskIntoConstraints = false
        return forwardToolbarButton
    }()
    
    lazy var refreshToolbarButton = {
        let refreshToolbarButton = UIButton()
        refreshToolbarButton.setImage(UIImage(systemName: "arrow.counterclockwise", withConfiguration: UIImage.SymbolConfiguration(pointSize: 25)), for: .normal)
        refreshToolbarButton.translatesAutoresizingMaskIntoConstraints = false
        return refreshToolbarButton
    }()
    
    lazy var shareToolbarButton = {
        let shareToolbarButton = UIButton()
        shareToolbarButton.setImage(UIImage(systemName: "square.and.arrow.up", withConfiguration: UIImage.SymbolConfiguration(pointSize: 25)), for: .normal)
        shareToolbarButton.translatesAutoresizingMaskIntoConstraints = false
        return shareToolbarButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor(red: 28, green: 28, blue: 30, alpha: 1)
        setupActions()
        setupWebView()
        setupView()
        
    }
    
    func setupActions() {
        refreshToolbarButton.addTarget(self, action: #selector(refreshButtonTapped), for: .touchUpInside)
        forwardToolbarButton.addTarget(self, action: #selector(forwardButtonTapped), for: .touchUpInside)
        rewindToolbarButton.addTarget(self, action: #selector(rewindButtonTapped), for: .touchUpInside)
        shareToolbarButton.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)
        
    }
    
    func setupWebView() {
        guard let url = URL(string: "https://www.apple.com/macbook-pro") else { return }
        let request = URLRequest(url: url)
        webView.navigationDelegate = self
        webView.load(request)
    }
    
    @objc func rewindButtonTapped() {
        if webView.canGoBack {
            webView.goBack()
        }
    }
    
    @objc func shareButtonTapped() {
        guard let url = URL(string: "https://www.apple.com/macbook-pro") else { return }
        let activityVC = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        self.present(activityVC, animated: true)
    }
    
    @objc func forwardButtonTapped() {
        if webView.canGoForward {
            webView.goForward()
        }
    }
    
    @objc func refreshButtonTapped() {
        webView.reload()
    }
    
    func setupView() {
        layout()
    }
    
 
    
    func layout() {
        
        toolbarLayout()
        webViewLayout()
    }
    
    func webViewLayout() {
        self.view.addSubview(webView)
        
        
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: toolbarView.topAnchor),
        ])
    }
    
    func toolbarLayout() {
        self.view.addSubview(toolbarView)
        toolbarView.addSubview(rewindToolbarButton)
        toolbarView.addSubview(refreshToolbarButton)
        toolbarView.addSubview(forwardToolbarButton)
        toolbarView.addSubview(shareToolbarButton)
        
        NSLayoutConstraint.activate([
            toolbarView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            toolbarView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            toolbarView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            toolbarView.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        NSLayoutConstraint.activate([
            rewindToolbarButton.centerYAnchor.constraint(equalTo: toolbarView.centerYAnchor),
            rewindToolbarButton.leadingAnchor.constraint(equalTo: toolbarView.leadingAnchor, constant: 10),
        ])
        
        NSLayoutConstraint.activate([
            refreshToolbarButton.trailingAnchor.constraint(equalTo: shareToolbarButton.leadingAnchor, constant: -10),
            refreshToolbarButton.centerYAnchor.constraint(equalTo: toolbarView.centerYAnchor),
        ])
        
        NSLayoutConstraint.activate([
            shareToolbarButton.centerYAnchor.constraint(equalTo: toolbarView.centerYAnchor),
            shareToolbarButton.trailingAnchor.constraint(equalTo: toolbarView.trailingAnchor, constant: -10),
        ])
        
        NSLayoutConstraint.activate([
            forwardToolbarButton.leadingAnchor.constraint(equalTo: rewindToolbarButton.trailingAnchor, constant: 10),
            forwardToolbarButton.centerYAnchor.constraint(equalTo: toolbarView.centerYAnchor),
        ])
    }
    

}


extension BrowserVC: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        if webView.canGoBack {
            rewindToolbarButton.isEnabled = true
        } else {
            rewindToolbarButton.isEnabled = false
        }
        
        if webView.canGoForward {
            forwardToolbarButton.isEnabled = true
        } else {
            forwardToolbarButton.isEnabled = false
        }
    }
}
