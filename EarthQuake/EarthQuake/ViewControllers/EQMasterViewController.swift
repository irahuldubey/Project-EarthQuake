//
//  EQMasterViewController.swift
//  EarthQuake
//
//  Created by Rahul Dubey on 3/8/21.
//

import UIKit
import RestServicePackage
import CorePackage

// List view controller for showing the earth quake details in a tabular format.
final class EQMasterViewController: UITableViewController, ActivityIndicatorProtocol {
    
    // Moved the datasourcce part in EQEarthQuakeDataSource for testability, maintainbility, resuability
    private let eqDataSource = EQEarthQuakeDataSource()
    // ViewModel - Holds the presentation logic for this view controller
    private var masterViewModel: EQMasterViewModelProtocol?
    // EarthQuakeArray - Array of EarthQuake entity which will be shown in the table view
    private var earthQuakeArray: [EQEarthQuake]?
    // is of type EQError - configured via view model to show meaniningful error code to the user
    private var eqError: EQError?
    var activityIndicator = UIActivityIndicatorView()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewModel()
        initDataSource()
        setupActivityIndicator()
        setupRefreshControl()
        setUpViewBinding()
        fetchSignificantEarthQuakesForPastThirtDays()
    }
    
    //MARK: - Private Helper Methods
    
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
        fetchSignificantEarthQuakesForPastThirtDays()
        tableView.reloadData()
        refreshControl?.endRefreshing()
    }

    /// Fetch the feeds from the API
    private func fetchSignificantEarthQuakesForPastThirtDays() {
        
        guard let masterViewModel = masterViewModel else { return }
        
        masterViewModel.fetchEarthQuakeSignificant(completion: { [weak self] (result) in
            guard let strongSelf = self else { return }
            switch(result) {
            case .success(let earthQuake):
                DispatchQueue.main.async {
                    strongSelf.earthQuakeArray = earthQuake
                    strongSelf.removeLoadingIndicator()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    // Handle UI Error and keep the reference of it in the view controller for later usage
                    strongSelf.eqError = error
                    strongSelf.removeLoadingIndicator()
                    strongSelf.alert(message: error.localizedDescription, title: "Failed to load")
                }
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
            // Pass the selected data via the Segue
            if let detailsViewController = segue.destination as? EQDetailsViewController {
                detailsViewController.setUpDetailsViewModel(with: sender as? EQEarthQuake)
            }
        default:
            break
        }
    }
}
