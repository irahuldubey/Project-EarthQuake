//
//  EQSplitViewController.swift
//  EarthQuake
//
//  Created by Rahul Dubey on 3/8/21.
//

import UIKit

class EQSplitViewController: UISplitViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        preferredDisplayMode = UISplitViewController.DisplayMode.oneBesideSecondary
    }
}

extension EQSplitViewController: UISplitViewControllerDelegate {
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController:UIViewController, onto primaryViewController:UIViewController) -> Bool {
        return true
    }
}
