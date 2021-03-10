//
//  EQError.swift
//  EarthQuake
//
//  Created by Rahul Dubey on 3/9/21.
//

import Foundation

enum EQError: Error {
    case networkError(string: String)
    case parserError(string: String)
    case customError(string: String)
}
