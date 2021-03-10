//
//  EQMasterViewModel.swift
//  EarthQuake
//
//  Created by Rahul Dubey on 3/9/21.
//

import Foundation
import CorePackage

protocol EQMasterViewModelProtocol {
    func fetchEarthQuakeSignificant(completion: @escaping((Result<[EQEarthQuake]?, EQError>)) -> Void)
}

struct EQMasterViewModel: EQMasterViewModelProtocol {
 
    weak var dataSource: GenericDataSource<EQEarthQuakeFeatures>?
    private var service: EQServiceProtocol?
    private var eqCacheManager: EQCacheManagerProtocol?

    // Handle Error on UI side
    var handleUIError : ((EQError?) -> Void)?
    
    init(with dataSource: GenericDataSource<EQEarthQuakeFeatures>?, andService service: EQServiceProtocol = EQService(),
         cacheManager: EQCacheManagerProtocol = EQCacheManager()) {
        self.dataSource = dataSource
        self.service = service
        self.eqCacheManager = cacheManager
    }
    
    func fetchEarthQuakeSignificant(completion: @escaping((Result<[EQEarthQuake]?, EQError>)) -> Void) {
        
       guard NetworkMonitor.shared.isNetworkConnectionEnabled else {
            if let localCacheManager = eqCacheManager,
               let eqData = localCacheManager.getEQData(),
               let dataSource = dataSource {
                    dataSource.data.value = [eqData]
                    completion(.success(eqData.earthQuakes))
                }
            return
        }
        
        guard let service = service  else {
            completion(.failure(EQError.customError(string: "Service Instance is nil")))
            return
        }
    
        service.fetchRecentEarthQuakeList(modelType: EQEarthQuakeFeatures.self) {(result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let earthQuakeFeature) :
                    if let dataSource = dataSource {
                        dataSource.data.value = [earthQuakeFeature]
                    }
                    if let localCacheManager = eqCacheManager {
                        localCacheManager.saveEQData(with: earthQuakeFeature) // save the new data in the primary cache
                    }
                    completion(.success(earthQuakeFeature.earthQuakes))
                case .failure( _):
                    completion(.failure(EQError.networkError(string: "Network Error")))
                }
            }
        }
    }
}
