//
//  EQEarthQuake.swift
//  EarthQuake
//
//  Created by Rahul Dubey on 3/9/21.
//

import Foundation

// MARK: - EQEarthQuake
public struct EQEarthQuake: Codable, Equatable {
    
    public let earthQuakeProperties: EQEarthQuakeProperties
    
    enum CodingKeys: String, CodingKey {
        case earthQuakeProperties = "properties"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        earthQuakeProperties = try container.decode(EQEarthQuakeProperties.self, forKey: .earthQuakeProperties)
    }
    
    public static func == (lhs: EQEarthQuake, rhs: EQEarthQuake) -> Bool {
        return lhs.earthQuakeProperties == rhs.earthQuakeProperties
    }
}
