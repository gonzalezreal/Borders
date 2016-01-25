//
//  Resource.swift
//  Borders
//
//  Created by Guillermo Gonzalez on 24/01/16.
//  Copyright © 2016 Guillermo Gonzalez. All rights reserved.
//

import Foundation

enum Method: String {
    case GET = "GET"
}

protocol Resource {
    var method: Method { get }
    var path: String { get }
    var parameters: [String: String] { get }
}

extension Resource {
    
    var method: Method {
        return .GET
    }
    
    func requestWithBaseURL(baseURL: NSURL) -> NSURLRequest {
        let URL = baseURL.URLByAppendingPathComponent(path)
        
        // NSURLComponents can fail due to programming errors, so
        // prefer crashing than returning an optional
        
        guard let components = NSURLComponents(URL: URL, resolvingAgainstBaseURL: false) else {
            fatalError("Unable to create URL components from \(URL)")
        }
        
        components.queryItems = parameters.map {
            NSURLQueryItem(name: String($0), value: String($1))
        }
        
        guard let finalURL = components.URL else {
            fatalError("Unable to retrieve final URL")
        }
        
        let request = NSMutableURLRequest(URL: finalURL)
        request.HTTPMethod = method.rawValue
        
        return request
    }
}

