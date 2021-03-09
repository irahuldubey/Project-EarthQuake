//
//  EQEarthQuakeProperties.swift
//  EarthQuake
//
//  Created by Rahul Dubey on 3/9/21.
//

import Foundation

//MARK: EQEarthQuakeProperties
public struct EQEarthQuakeProperties: Codable, Equatable {
    
    public let magnitude: Double
    public let usgsUrl: String
    public let title: String
    public let status: String
    
    enum CodingKeys: String, CodingKey {
        case magnitude = "mag"
        case usgsUrl = "url"
        case title
        case status
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        magnitude = try container.decode(Double.self, forKey: .magnitude)
        usgsUrl = try container.decode(String.self, forKey: .usgsUrl)
        title = try container.decode(String.self, forKey: .title)
        status = try container.decode(String.self, forKey: .status)
    }
}
