//
//  RestServiceResponse.swift
//  RestServicePackage
//
//  Created by Rahul Dubey on 3/8/21.
//

import Foundation

public struct RestServiceResponseParser {
    
    // Reference: https://developer.mozilla.org/en-US/docs/Web/HTTP/Status
    public enum Status {
        case informational(Int)
        case success(Int)
        case redirection(Int)
        case clientError(Int)
        case serverError(Int)
        
        init?(statusCode: Int) {
            switch statusCode {
            case 100...199:
                self = .informational(statusCode)
            case 200...299:
                self = .success(statusCode)
            case 300...399:
                self = .redirection(statusCode)
            case 400...499:
                self = .clientError(statusCode)
            case 500...599:
                self = .serverError(statusCode)
            default:
                return nil
            }
        }
    }
    
    public let status: Status
    public let data: Data?
    public let headers: [AnyHashable: Any]
    
    // MARK: Initializer
    public init(withResponse response: HTTPURLResponse, data: Data?) throws {
        let statusCode = response.statusCode
        guard let status = Status.init(statusCode: statusCode) else {
            throw RestServiceError.invalidStatusCode(statusCode)
        }
        self.status = status
        self.data = data
        self.headers = response.allHeaderFields
    }
}
