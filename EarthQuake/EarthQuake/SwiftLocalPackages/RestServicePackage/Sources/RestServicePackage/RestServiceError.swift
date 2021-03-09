//
//  RestServiceError.swift
//  RestServicePackage
//
//  Created by Rahul Dubey on 3/8/21.
//

import Foundation

public enum RestServiceError: Error {
    case invalidOperation(Error)
    case invalidStatusCode(Int)
    case unknown
}
