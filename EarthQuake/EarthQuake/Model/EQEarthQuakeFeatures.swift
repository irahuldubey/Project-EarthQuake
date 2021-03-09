//
//  EQEarthQuakeFeatures.swift
//  EarthQuake
//
//  Created by Rahul Dubey on 3/9/21.
//

import Foundation

//MARK: EQEarthQuakeFeatures
public struct EQEarthQuakeFeatures: Codable {
    
    public let earthQuakes: [EQEarthQuake]
    public let metaData: EQEarthMetaData
    
    enum CodingKeys: String, CodingKey {
        case earthQuakes = "features"
        case metaData = "metadata"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        earthQuakes = try container.decode([EQEarthQuake].self, forKey: .earthQuakes)
        metaData = try container.decode(EQEarthMetaData.self, forKey: .metaData)
    }
}
