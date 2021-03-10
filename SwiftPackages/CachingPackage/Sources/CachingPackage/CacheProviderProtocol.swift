//
//  CacheProviderProtocol.swift
//  
//
//  Created by Rahul Dubey on 3/10/21.
//

import Foundation

public protocol CacheProviderProtocol {
    
    func load(key: String) -> Data?
    
    func save(key: String, value: NSData?)
    
    func clearCache()
    
}
