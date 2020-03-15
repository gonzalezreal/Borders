//
//  ResourceTests.swift
//  Borders
//
//  Created by Guillermo Gonzalez on 24/01/16.
//  Copyright © 2016 Guillermo Gonzalez. All rights reserved.
//

import XCTest
@testable import Borders

class ResourceTests: XCTestCase {
    
    func testRequestWithBaseURL() {
        
        enum TestResource: Resource {
            case Example
            
            var path: String { return "example" }
            var parameters: [String: String] {
                return [
                    "foo": "bar",
                    "bar": "foo"
                ]
            }
        }
        
        let baseURL = URL(string: "https://example.com/api/v2")!
        let request = TestResource.Example.requestWithBaseURL(baseURL: baseURL)
        let expectedURL = URL(string: "https://example.com/api/v2/example?bar=foo&foo=bar")!
        let URL = request.url
        
        XCTAssertEqual(expectedURL, URL)
    }
}
