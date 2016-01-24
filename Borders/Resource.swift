//
//  Resource.swift
//  Borders
//
//  Created by Guillermo Gonzalez on 24/01/16.
//  Copyright © 2016 Guillermo Gonzalez. All rights reserved.
//

import Foundation

protocol URLQueryConvertible {
    func queryItems() -> [NSURLQueryItem]
}

extension Dictionary: URLQueryConvertible {
    func queryItems() -> [NSURLQueryItem] {
        return map { NSURLQueryItem(name: String($0), value: String($1)) }
    }
}

enum Method: String {
    case GET = "GET"
}

protocol Resource {
    var method: Method { get }
    var path: String { get }
    var parameters: URLQueryConvertible { get }
}

extension Resource {
    
    var method: Method {
        return .GET
    }
    
    var parameters: URLQueryConvertible {
        return [String: String]()
    }
    
    func requestWithBaseURL(baseURL: NSURL) -> NSURLRequest {
        let URL = baseURL.URLByAppendingPathComponent(path)
        
        // NSURLComponents can fail due to programming errors, so
        // prefer crashing than returning an optional
        
        guard let components = NSURLComponents(URL: URL, resolvingAgainstBaseURL: false) else {
            fatalError("Unable to create URL components from \(URL)")
        }
        
        components.queryItems = parameters.queryItems()
        
        guard let finalURL = components.URL else {
            fatalError("Unable to retrieve final URL")
        }
        
        let request = NSMutableURLRequest(URL: finalURL)
        request.HTTPMethod = method.rawValue
        
        return request
    }
}

