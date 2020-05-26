//
//  ViewController.swift
//  Project4
//
//  Created by Aaron Dupont on 5/12/20.
//  Copyright © 2020 AaronDupont. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {

    var webView: WKWebView!
    var progressView: UIProgressView!
    var websites = ["apple.com", "google.com", "twitter.com"]

    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
        let backButton = UIBarButtonItem(image: UIImage(systemName: "arrowtriangle.left.fill"), style: .plain, target: self, action: #selector(backTapped))
        let forwardButton = UIBarButtonItem(image: UIImage(systemName: "arrowtriangle.right.fill"), style: .plain, target: self, action: #selector(forwardTapped))
        navigationItem.leftBarButtonItems = [backButton, forwardButton]
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        
        
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        let progressButton = UIBarButtonItem(customView: progressView)
        
        toolbarItems = [progressButton, spacer, refresh]
        navigationController?.isToolbarHidden = false
        
        
        let url = URL(string: "https://"+websites[0])!
        
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
    
    @objc func backTapped() {
        webView.goBack()
    }
    
    @objc func forwardTapped() {
        webView.goForward()
    }

    @objc func openTapped() {
        let ac = UIAlertController(title: "Open page", message: nil, preferredStyle: .actionSheet)
        
        for website in websites {
            ac.addAction(UIAlertAction(title: website, style: .default, handler: openPage))
        }
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(ac, animated: true)
    }
    
    func openPage(action: UIAlertAction) {
        guard let actionTitle = action.title else { return }
        guard let url = URL(string: "https://"+actionTitle) else { return }
        webView.load(URLRequest(url: url))
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url
        
        if let host = url?.host {
            for website in websites {
                if host.contains(website) {
                    if let path = url?.path {
                        if path != "/" { //if anywhere other than the base path then block access
                            let ac = UIAlertController(title: "Access blocked", message: "You cannot visit this page.", preferredStyle: .alert)
                            ac.addAction(UIAlertAction(title: "Candel", style: .cancel))
                            present(ac, animated: true)
                            decisionHandler(.cancel)
                            return
                        }
                    }
                    decisionHandler(.allow)
                    return
                }
                
            }
        }
        
        decisionHandler(.cancel)
    }

}

