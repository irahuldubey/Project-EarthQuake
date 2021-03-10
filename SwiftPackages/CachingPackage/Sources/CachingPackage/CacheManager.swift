//
//  CacheManager.swift
//
//
//  Created by Rahul Dubey on 3/10/21.
//

import Foundation
public class CacheManager: CacheManagerProtocol {
    
    public static let shared: CacheManagerProtocol = CacheManager()
    
    public var primaryCache: CacheProviderProtocol = MemoryCacheProvider()
    public var secondaryCache: CacheProviderProtocol? = FileCacheProvider(cacheDir: "CacheDirectory")
    
    public subscript(key: String) -> Data? {
        get {
            guard let result = primaryCache.load(key: key) else {
                if let file = secondaryCache?.load(key: key) {
                    primaryCache.save(key: key, value: file as NSData?)
                    return file
                }
                return nil
            }
            return result
        }
        set {
            let data: NSData? = newValue as NSData?
            primaryCache.save(key: key, value: data)
            secondaryCache?.save(key: key, value: data)
        }
    }
    
    public func clearCache() {
        primaryCache.clearCache()
        secondaryCache?.clearCache()
    }
}
