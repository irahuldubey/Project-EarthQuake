//
//  CacheManagerProtocol.swift
//  
//
//  Created by Rahul Dubey on 3/10/21.
//

import Foundation

public protocol CacheManagerProtocol {
    
    var primaryCache: CacheProviderProtocol { get set }
    
    var secondaryCache: CacheProviderProtocol? { get set }
    
    subscript(key: String) -> Data? { get set }
    
    func clearCache()
}
