//
//  DetailsViewController.swift
//  EarthQuake
//
//  Created by Rahul Dubey on 3/8/21.
//

import UIKit
import WebKit
import CorePackage

class EQDetailsViewController: UIViewController, ActivityIndicatorProtocol {

    @IBOutlet weak var wkWebView: WKWebView!
    private var detailsViewModel: EQDetailsViewModel?
    var activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Show the loading spinner when page starts to load
        showLoadingIndicator(withSize: CGSize.init(width: 100, height: 100))
        // Set the navigation title as the selected index title from the master view
        self.navigationItem.title = detailsViewModel?.title
        self.wkWebView.navigationDelegate = self
        loadWebView()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        wkWebView.stopLoading()
    }
    
    func setUpDetailsViewModel(with earthQuake: EQEarthQuake?) {
        guard let earthQuake = earthQuake else {
            return
        }
        detailsViewModel = EQDetailsViewModel.init(with: earthQuake)
    }
    
    private func loadWebView() {
        guard let urlRequest = detailsViewModel?.urlRequest else {
            return
        }
        if NetworkMonitor.shared.isNetworkConnectionEnabled {
            self.wkWebView.load(urlRequest)
        } else {
            alert(message: MesasgeStrings.connectionAlertMessage, title: MesasgeStrings.connectionAlertTitle)
        }
    }
}

//MARK: WKNavigationDelegate
extension EQDetailsViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        removeLoadingIndicator() // Hide the loading spinner
        alert(message: MesasgeStrings.webViewError, title: MesasgeStrings.webViewTitle)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        removeLoadingIndicator() // Hide the loading spinner
    }
}
