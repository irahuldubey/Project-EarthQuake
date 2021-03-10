//
//  EQCacheManager.swift
//  EarthQuake
//
//  Created by Rahul Dubey on 3/10/21.
//

import Foundation
import CachingPackage

protocol EQCacheManagerProtocol {
    func saveEQData(with: EQEarthQuakeFeatures)
    func getEQData() -> EQEarthQuakeFeatures?
    func clearCache()
}

final class EQCacheManager: EQCacheManagerProtocol {
    
    private var cacheManager: CacheManagerProtocol?
    private let cacheKey = "eqCacheKey"
    init(with cacheManager: CacheManagerProtocol = CacheManager.shared) {
        self.cacheManager = cacheManager
    }
   
    func saveEQData(with earthQuakes: EQEarthQuakeFeatures) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(earthQuakes)  {
            self.cacheManager?[cacheKey] = encoded
        }
    }
    
    func getEQData() -> EQEarthQuakeFeatures? {
        guard  let cacheManager = cacheManager else {
            return nil
        }
        let jsonDecoder = JSONDecoder()
        if let savedData = cacheManager[cacheKey] {
            if let cacheKey = try? jsonDecoder.decode(EQEarthQuakeFeatures.self, from: savedData) {
                return cacheKey
            }
        }
        return nil
    }
    
    func clearCache() {
        guard let cacheManager = cacheManager else {
            return
        }
        cacheManager.clearCache()
    }
}
