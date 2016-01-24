//
//  APIClient.swift
//  Borders
//
//  Created by Guillermo Gonzalez on 24/01/16.
//  Copyright © 2016 Guillermo Gonzalez. All rights reserved.
//

import Foundation
import RxSwift

enum APIClientError: ErrorType {
    case CouldNotDecodeJSON
    case BadStatus(status: Int)
    case Other(NSError)
}

extension APIClientError: CustomDebugStringConvertible {
    var debugDescription: String {
        switch self {
        case .CouldNotDecodeJSON:
            return "Could not decode JSON"
        case let .BadStatus(status):
            return "Bad status \(status)"
        case let .Other(error):
            return "\(error)"
        }
    }
}

final class APIClient {
    
    init(baseURL: NSURL, configuration: NSURLSessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()) {
        self.baseURL = baseURL
        self.session = NSURLSession(configuration: configuration)
    }
    
    func objects<T: JSONDecodable>(resource: Resource) -> Observable<[T]> {
        return data(resource).map { data in
            guard let objects: [T] = decode(data) else {
                throw APIClientError.CouldNotDecodeJSON
            }
            
            return objects
        }
    }
    
    // MARK: - Private
    
    private let baseURL: NSURL
    private let session: NSURLSession
    
    private func data(resource: Resource) -> Observable<NSData> {
        
        let request = resource.requestWithBaseURL(baseURL)
        
        return Observable.create { observer in
            let task = self.session.dataTaskWithRequest(request) { data, response, error in
                
                if let error = error {
                    observer.onError(APIClientError.Other(error))
                } else {
                    guard let HTTPResponse = response as? NSHTTPURLResponse else {
                        fatalError("Couldn't get HTTP response")
                    }
                    
                    if 200 ..< 300 ~= HTTPResponse.statusCode {
                        observer.onNext(data ?? NSData())
                    }
                    else {
                        observer.onError(APIClientError.BadStatus(status: HTTPResponse.statusCode))
                    }
                }
            }
            
            task.resume()
            
            return AnonymousDisposable {
                task.cancel()
            }
        }
    }
}
