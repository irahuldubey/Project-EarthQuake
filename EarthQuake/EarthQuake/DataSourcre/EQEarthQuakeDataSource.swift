//
//  EarthQuakeDataSource.swift
//  EarthQuake
//
//  Created by Rahul Dubey on 3/9/21.
//

import Foundation
import UIKit
import CorePackage

class GenericDataSource<T> : NSObject {
    var data: DynamicBindingObserver<[T]> = DynamicBindingObserver([])
}

final class EQEarthQuakeDataSource: GenericDataSource<EQEarthQuakeFeatures>, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let features = data.value.first
        return features?.metaData.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let eqCell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifiers.eqCellIdentifier, for: indexPath) as? EQFeatureTableViewCell {
            guard let earthQuake = data.value.first?.earthQuakes[indexPath.row] else { return UITableViewCell() }
            eqCell.setupCell(with: earthQuake)
            return eqCell
        }
        return UITableViewCell()
    }
}
