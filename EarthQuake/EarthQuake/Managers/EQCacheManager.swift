//
//  EQCacheManager.swift
//  EarthQuake
//
//  Created by Rahul Dubey on 3/10/21.
//

import Foundation
import CachingPackage

// Basic Operation of caching
protocol EQCacheManagerProtocol {
    func saveEQData(with: EQEarthQuakeFeatures)
    func getEQData() -> EQEarthQuakeFeatures?
    func clearCache()
}

// Wrapper over Cache Manager from Caching Package
final class EQCacheManager: EQCacheManagerProtocol {
    
    // if of type CacheManagerProtocol, holds an instance of CacheManager
    private var cacheManager: CacheManagerProtocol?
    // use this key in the hashmap table to store the earthQuake Data
    private let cacheKey = "eqCacheKey"
    
    /// Class Initializer
    /// - Parameter cacheManager: is of type CacheManagerProtocol,
    init(with cacheManager: CacheManagerProtocol = CacheManager.shared) {
        self.cacheManager = cacheManager
    }
   
    /// Save the Entity to the HashMap - Primary or Seconday
    /// - Parameter earthQuakes: stores the parent object EQEarthQuakeFeatures, so that it can be used whereever needed
    func saveEQData(with earthQuakes: EQEarthQuakeFeatures) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(earthQuakes)  {
            self.cacheManager?[cacheKey] = encoded
        }
    }
    
    /// Get the Entity data from the HashMap using the cacheKey
    /// - Returns: is of type EQEarthQuakeFeatures or nil
    func getEQData() -> EQEarthQuakeFeatures? {
        guard  let cacheManager = cacheManager else {
            return nil
        }
        let jsonDecoder = JSONDecoder()
        if let savedData = cacheManager[cacheKey],
           let cacheKey = try? jsonDecoder.decode(EQEarthQuakeFeatures.self, from: savedData) {
            return cacheKey
        }
        return nil
    }
    
    func clearCache() {
        cacheManager?.clearCache()
    }
}
