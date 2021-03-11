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

    // Hold the reference of wkWebView to load the usgsURL
    @IBOutlet weak var wkWebView: WKWebView!
    
    // Show the internet connectivity icon when user is offline
    @IBOutlet weak var offlineImageView: UIImageView!

    // EQDetails viewmodel provides data to this view controller
    private var detailsViewModel: EQDetailsViewModel?
    
    // Reference of activity indicator to show the spinner when the url is loading in the webview
    var activityIndicator = UIActivityIndicatorView()
    
    // MARK: - ViewLifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Show the loading spinner when page starts to load
        showLoadingIndicator(withSize: CGSize.init(width: 100, height: 100))
        // Set the navigation title as the selected index title from the master view
        self.navigationItem.title = detailsViewModel?.title
        self.wkWebView.navigationDelegate = self
        self.offlineImageView.isHidden = true
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
            DispatchQueue.main.async { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.removeLoadingIndicator() // Hide the loading spinner
                strongSelf.alert(message: MesasgeStrings.connectionAlertMessage, title: MesasgeStrings.connectionAlertTitle)
                strongSelf.offlineImageView.isHidden = false
            }
        }
    }
}

//MARK: WKNavigationDelegate
extension EQDetailsViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.removeLoadingIndicator() // Hide the loading spinner
            strongSelf.alert(message: MesasgeStrings.webViewError, title: MesasgeStrings.webViewTitle)
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.removeLoadingIndicator() // Hide the loading spinner
        }
    }
}
