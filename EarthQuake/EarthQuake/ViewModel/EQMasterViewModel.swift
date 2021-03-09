//
//  EQMasterViewModel.swift
//  EarthQuake
//
//  Created by Rahul Dubey on 3/9/21.
//

import Foundation

protocol EQMasterViewModelProtocol {
    func fetchEarthQuakeSignificant()
}

final class EQMasterViewModel: EQMasterViewModelProtocol {
 
    func fetchEarthQuakeSignificant() { }
    
    private let dataSource: EQEarthQuakeDataSource
    
    init(with dataSource: EQEarthQuakeDataSource) {
        self.dataSource = dataSource
    }
}
