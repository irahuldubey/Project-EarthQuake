//
//  EQMasterViewController.swift
//  EarthQuake
//
//  Created by Rahul Dubey on 3/8/21.
//

import UIKit
import RestServicePackage

protocol EQDetailsViewControllerDelegate: class {
    func selectedEarthQuakeZone()
}

final class EQMasterViewController: UITableViewController {
    
    weak var delegate: EQDetailsViewControllerDelegate?
    private let eqDataSource = EarthQuakeDataSource()
    private var masterViewModel: EQMasterViewModelProtocol?
    
    /*
    // Dependency Injection for Unit Testing the View Controller
    init(viewModel: EQMasterViewModelProtocol, eqDataSource: EarthQuakeDataSource = EQEarthQuakeDataSource()) {
        self.viewModel = EQMasterViewModel(with: eqDataSource)
        super.init(style: .plain)
        self.tableView.dataSource = eqDataSource
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        masterViewModel = EQMasterViewModel.init(with: eqDataSource)
        
        self.tableView.dataSource = self.eqDataSource
        
        eqDataSource.data.addAndNotify(observer: self) { _ in
            self.tableView.reloadData()
        }
        
        // add error handling example
        self.masterViewModel?.handleUIError = { [weak self] error in
            let controller = UIAlertController(title: "An error occured", message: "Oops, something went wrong!", preferredStyle: .alert)
            controller.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
            self?.present(controller, animated: true, completion: nil)
        }
        
        masterViewModel?.fetchEarthQuakeSignificant()
    }
}
