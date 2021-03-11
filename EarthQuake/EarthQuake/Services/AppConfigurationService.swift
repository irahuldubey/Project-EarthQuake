//
//  AppConfigurationService.swift
//  EarthQuake
//
//  Created by Rahul Dubey on 3/9/21.
//

import Foundation
/*
 AppConfigurationService : This is one of the service which gets called at the start up of the application to load any configuration data.
 We can change the domain, path and other API configurations
 We can add timer values wherever used in the application and add those keys in the configuration service
 We can use encryption algorithm to encrypt the payload we receive from the service so that it cannot be mad in the middle attacked.
 If this service grows along with other service at start up which is different from the API group I would prefer adding this in a package.
*/

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
