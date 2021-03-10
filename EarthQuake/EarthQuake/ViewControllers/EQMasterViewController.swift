//
//  EQMasterViewController.swift
//  EarthQuake
//
//  Created by Rahul Dubey on 3/8/21.
//

import UIKit
import RestServicePackage
import CorePackage

final class EQMasterViewController: UITableViewController, ActivityIndicatorProtocol {
    
    private let eqDataSource = EQEarthQuakeDataSource()
    private var masterViewModel: EQMasterViewModelProtocol?
    private var earthQuakeArray: [EQEarthQuake]?
    private var eqError: EQError?
    var activityIndicator = UIActivityIndicatorView()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewModel()
        initDataSource()
        setupActivityIndicator()
        setupRefreshControl()
        setUpViewBinding()
        fetchSignificantEarthQuakes()
    }
    
    private func setupActivityIndicator() {
        showLoadingIndicator(withSize: CGSize.init(width: 100, height: 100))
        activityIndicator.color = .black
    }
    
    private func initViewModel() {
        masterViewModel = EQMasterViewModel.init(with: eqDataSource)
    }
    
    private func initDataSource() {
        self.tableView.dataSource = self.eqDataSource
    }
    
    private func setUpViewBinding() {
        eqDataSource.data.addAndNotify(observer: self) { _ in
            self.tableView.reloadData()
        }
    }

    private func setupRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:  #selector(refreshPageWithNewContents), for: .valueChanged)
        self.refreshControl = refreshControl
    }
    
    @objc private func refreshPageWithNewContents() {
        fetchSignificantEarthQuakes()
        tableView.reloadData()
        refreshControl?.endRefreshing()
    }
    
    private func fetchSignificantEarthQuakes() {
        
        guard let masterViewModel = masterViewModel else { return }
        
        guard NetworkMonitor.shared.isNetworkConnectionEnabled else {
            alert(message: MesasgeStrings.connectionAlertMessage, title: MesasgeStrings.connectionAlertTitle)
            removeLoadingIndicator()
            // We can do any UI customization here like showing a toast message from the top of the view controller.
            return
        }
        
        masterViewModel.fetchEarthQuakeSignificant(completion: { [weak self] (result) in
            guard let strongSelf = self else { return }
            switch(result) {
            case .success(let earthQuake):
                strongSelf.earthQuakeArray = earthQuake
                strongSelf.removeLoadingIndicator()
            case .failure(let error):
                // Handle UI Error and keep the reference of it in the view controller for later usage
                strongSelf.eqError = error
                strongSelf.removeLoadingIndicator()
                strongSelf.alert(message: error.localizedDescription, title: "Failed to load")
            }
        })
    }
}

//MARK: UITableViewDelegate
extension EQMasterViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let earthQuakeArray = earthQuakeArray {
            let selectedEarthQuakeIndex = earthQuakeArray[indexPath.row]
            self.performSegue(withIdentifier: SegueIdentifiers.detail, sender: selectedEarthQuakeIndex)
        }
    }
}

// MARK: - Navigation
extension EQMasterViewController {
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let segueId = segue.identifier else {
          return
        }
        switch segueId {
        case SegueIdentifiers.detail :
            if let detailsViewController = segue.destination as? EQDetailsViewController {
                detailsViewController.setUpDetailsViewModel(with: sender as? EQEarthQuake)
            }
        default:
            break
        }
    }
}
