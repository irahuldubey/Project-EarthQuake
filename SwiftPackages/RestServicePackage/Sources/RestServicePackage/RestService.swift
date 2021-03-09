//
//  RestService.swift
//  RestServicePackage
//
//  Created by Rahul Dubey on 3/8/21.
//

import Foundation

public class RestService<T: RestServiceOperation> {
    
    //MARK: Private Properties
    
    private let sessionConfiguration: URLSessionConfiguration
    
    private lazy var session: URLSession = {
        return URLSession.init(configuration: sessionConfiguration)
    }()
    
    private lazy var restServiceResponseHandler: RestServiceResponseHandler = {
        return RestServiceResponseHandler()
    }()
    
    //MARK: Intializer
    
    public init(sessionConfiguration: URLSessionConfiguration = .default) {
        self.sessionConfiguration = sessionConfiguration
    }
    
    public func performRestServiceOperation(_ operation: RestServiceOperation, completionHandler: @escaping (Result<RestServiceResponseParser>) -> Void) -> URLSessionTask? {
        do {
            let request = try operation.requestURL()
            let task = session.dataTask(with: request) { (data, response, error) in
                let response = RestServiceResponseData.init(data: data, response: response, error: error as Error?)
                self.restServiceResponseHandler.handle(urlResponse: response, completion: completionHandler)
            }
            task.resume() // Initiate the webservice call
            return task
        } catch {
            completionHandler(.failure(RestServiceError.unknown))
            return nil
        }
    }
}


