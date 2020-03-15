//
//  APIClient.swift
//  Borders
//
//  Created by Guillermo Gonzalez on 24/01/16.
//  Copyright © 2016 Guillermo Gonzalez. All rights reserved.
//

import UIKit
import RxSwift

enum APIClientError: Error {
    case CouldNotDecodeJSON
    case BadStatus(status: Int)
    case Other(Error)
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
    
    init(baseURL: URL, configuration: URLSessionConfiguration = .default) {
        self.baseURL = baseURL
        self.session = URLSession(configuration: configuration)
    }
    
    func objects<T: JSONDecodable>(resource: Resource) -> Observable<[T]> {
        return data(resource: resource).map { data in
            guard let objects: [T] = decode(data: data) else {
                throw APIClientError.CouldNotDecodeJSON
            }
            
            return objects
        }
    }
    
    // MARK: - Private
    
    private let baseURL: URL
    private let session: URLSession
    
    private func data(resource: Resource) -> Observable<Data> {
        
        let request = resource.requestWithBaseURL(baseURL: baseURL)
        
        return Observable.create { observer in
            let task = self.session.dataTask(with: request) { data, response, error in
                guard error == nil, let data = data else {
                    observer.onError(APIClientError.Other(error!))
                    return
                }
                
                guard let HTTPResponse = response as? HTTPURLResponse else {
                    fatalError("Couldn't get HTTP response")
                }
                
                if 200 ..< 300 ~= HTTPResponse.statusCode {
                    observer.onNext(data)
                    observer.onCompleted()
                }
                else {
                    observer.onError(APIClientError.BadStatus(status: HTTPResponse.statusCode))
                }
            }
            
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
