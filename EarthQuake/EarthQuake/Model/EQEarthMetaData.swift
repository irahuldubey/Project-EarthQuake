//
//  EQEarthMetaData.swift
//  EarthQuake
//
//  Created by Rahul Dubey on 3/9/21.
//

import Foundation

// MARK: EQEarthMetaData
public struct EQEarthMetaData: Codable {
    
    public let count: Int
    public let url: String
    public let title: String

    enum CodingKeys: String, CodingKey {
        case count
        case url
        case title
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        count = try container.decode(Int.self, forKey: .count)
        url = try container.decode(String.self, forKey: .url)
        title = try container.decode(String.self, forKey: .title)
    }
}
