//
//  AppConfigurationService.swift
//  EarthQuake
//
//  Created by Rahul Dubey on 3/9/21.
//

import Foundation

protocol AppConfigurationServiceProtocol {
    func loadRemoteConfiguration() -> [String: String]
    func loadLocalConfiguration() -> [String: String]
}

struct AppConfigurationService: AppConfigurationServiceProtocol {
   
    var eqDomain: String { return loadRemoteConfiguration()["domain"] ?? "" }
    var eqPath: String { return loadRemoteConfiguration()["path"] ?? "" }
    
    // Call the remote service and get the configuration
    func loadRemoteConfiguration() -> [String: String] {
        var configDictionary = [String: String]()
        configDictionary["domain"] = "earthquake.usgs.gov"
        configDictionary["path"] = "/earthquakes/feed/v1.0/summary/significant_month.geojson"
        return configDictionary
    }
    
    // Call the local cache get the configuration
    func loadLocalConfiguration() -> [String: String] {
        return [:]
    }
}
