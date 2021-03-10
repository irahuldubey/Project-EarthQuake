//
//  EQService.swift
//  EarthQuake
//
//  Created by Rahul Dubey on 3/9/21.
//

import Foundation
import RestServicePackage

public protocol EQServiceProtocol {
    @discardableResult func fetchRecentEarthQuakeList<T: Codable>(modelType: T.Type, completionHandler: @escaping(Result<T>) -> Void) -> Cancellable? 
}

// If we want to cancel the request from our application layer.
public protocol Cancellable {
    func cancel()
}

extension URLSessionTask: Cancellable {}

final class EQService: EQServiceProtocol {
    
    enum Error: Swift.Error {
        case invalidResponse(Int)
        case parseError
    }
    
    init() { }
    
    private let restService: RestService<EQServiceOperation> = RestService()
    
    private lazy var decoder: JSONDecoder = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        return decoder
    }()

    @discardableResult // If we don't want to handle cancellable dispatch
    func fetchRecentEarthQuakeList<T: Codable>(modelType: T.Type, completionHandler: @escaping(Result<T>) -> Void) -> Cancellable? {
        let eqOperation: EQServiceOperation = .fetchRecentEarthQuakeList
        return restService.performRestServiceOperation(eqOperation) { (result) in
            switch result {
            case .success(let response):
                switch response.status {
                case .informational(let code),
                     .redirection(let code),
                     .clientError(let code),
                     .serverError(let code):
                    let error = Error.invalidResponse(code)
                    completionHandler(.failure(error))
                case .success:
                    if let data = response.data {
                        do {
                            let earthquakeFeatureResponse = try self.decoder.decode(T.self, from: data)
                            completionHandler(.success(earthquakeFeatureResponse))
                        } catch {
                            completionHandler(.failure(error))
                        }
                    }
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}
