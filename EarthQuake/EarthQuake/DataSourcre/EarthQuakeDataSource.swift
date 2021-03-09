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
    // Right now we will keep a hard coded value for number of sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
        //return data.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        return cell
    }
}
