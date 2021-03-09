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
    private var viewModel: EQMasterViewModelProtocol?
    
    // Dependency Injection for Unit Testing the View Controller
    init(viewModel: EQMasterViewModelProtocol = EQMasterViewModel()) {
        self.viewModel = viewModel
        super.init(style: .plain)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        EQService().fetchRecentEarthQuakeList(modelType: EQEarthQuakeFeatures.self, completionHandler: { [weak self] (result) in
            switch result {
            case .success(let eqFeatures):
                print(eqFeatures)
            case .failure(let error):
                print(error)
            }
        })
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let delegate = delegate as? EQDetailsViewController {
            showDetailViewController(delegate, sender: nil)
        }
    }
}
