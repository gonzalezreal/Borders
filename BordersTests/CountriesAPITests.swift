//
//  CountriesAPITests.swift
//  Borders
//
//  Created by Guillermo Gonzalez on 24/01/16.
//  Copyright © 2016 Guillermo Gonzalez. All rights reserved.
//

import XCTest
@testable import Borders

class CountriesAPITests: XCTestCase {
    
    func testNameResource() {
        let name = CountriesAPI.Name(name: "China")
        
        XCTAssertEqual(Method.GET, name.method)
        XCTAssertEqual("name/China", name.path)
        XCTAssertEqual(["fullText": "true"], name.parameters)
    }
    
    func testAlphaCodesResource() {
        let alphaCodes = CountriesAPI.AlphaCodes(codes: ["es", "fr"])
        
        XCTAssertEqual(Method.GET, alphaCodes.method)
        XCTAssertEqual("alpha", alphaCodes.path)
        XCTAssertEqual(["codes": "es;fr"], alphaCodes.parameters)
    }
}
