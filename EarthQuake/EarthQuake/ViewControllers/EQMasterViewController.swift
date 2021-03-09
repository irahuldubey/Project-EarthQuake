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
    private let eqDataSource = EQEarthQuakeDataSource()
    private var viewModel: EQMasterViewModelProtocol?
    
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
        
        viewModel = EQMasterViewModel.init(with: eqDataSource)
        
        self.tableView.dataSource = self.eqDataSource
        
        self.eqDataSource.data.addAndNotify(observer: self) { [weak self] _ in
            guard let strongSelf = self else { return }
            strongSelf.tableView.reloadData()
        }
    }
}
