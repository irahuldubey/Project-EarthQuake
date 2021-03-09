//
//  EQServiceOperation.swift
//  EarthQuake
//
//  Created by Rahul Dubey on 3/9/21.
//

import Foundation
import RestServicePackage

// Add the list of services
public enum EQServiceOperation {
    case fetchRecentEarthQuakeList
}

extension EQServiceOperation: RestServiceOperation {
    
    public typealias Components = RestServiceRequestConfiguration.PathComponents
    
    private struct Constants {
        static let base = AppConfigurationService().eqDomain
        enum EndPoint: String {
            case significantThirtyDays
        }
    }
    
    public var configuration: RestServiceRequestConfiguration {
        let pathComponents = self.pathComponents
        return RestServiceRequestConfiguration(urlString: Constants.base,
                                               scheme: .https,
                                               method: .get,
                                               contentType: .json,
                                               urlComponents: pathComponents)
    }
    
    private var pathComponents: Components {
        return Components(path: path, queryItems: queryItems)
    }
    
    private var path: String {
        switch self {
        case .fetchRecentEarthQuakeList:
            return AppConfigurationService().eqPath
        }
    }
    
    private var endPoints: Constants.EndPoint {
        switch self {
        case .fetchRecentEarthQuakeList:
            return Constants.EndPoint.significantThirtyDays
        }
    }
    
    private var queryItems: [String: String?]? {
        return nil // as of now we are not using any query parameter for the EQServiceOperation so returning as nil
    }

    private var queryDictionary: [String: String?]? {
        switch self {
        case .fetchRecentEarthQuakeList:
            return nil
    }
  }
}
