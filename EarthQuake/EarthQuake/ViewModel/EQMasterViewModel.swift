//
//  EQMasterViewModel.swift
//  EarthQuake
//
//  Created by Rahul Dubey on 3/9/21.
//

import Foundation

protocol EQMasterViewModelProtocol {
    func fetchEarthQuakeSignificant(completion: @escaping((Result<[EQEarthQuake]?, EQError>)) -> Void)
}

struct EQMasterViewModel: EQMasterViewModelProtocol {
 
    weak var dataSource: GenericDataSource<EQEarthQuakeFeatures>?
    private var service: EQServiceProtocol?

    // Handle Error on UI side
    var handleUIError : ((EQError?) -> Void)?
    
    init(with dataSource: GenericDataSource<EQEarthQuakeFeatures>?, andService service: EQServiceProtocol = EQService()) {
        self.dataSource = dataSource
        self.service = service
    }
    
    func fetchEarthQuakeSignificant(completion: @escaping((Result<[EQEarthQuake]?, EQError>)) -> Void) {

        guard let service = service  else {
            return
        }
        
        service.fetchRecentEarthQuakeList(modelType: EQEarthQuakeFeatures.self) {(result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let earthQuakeFeature) :
                    if let dataSource = dataSource {
                        dataSource.data.value = [earthQuakeFeature]
                    }
                    completion(.success(earthQuakeFeature.earthQuakes))
                case .failure( _):
                    completion(.failure(EQError.networkError(string: "Network Error")))
                }
            }
        }
    }
}
