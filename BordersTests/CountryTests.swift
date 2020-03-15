//
//  CountryTests.swift
//  Borders
//
//  Created by Guillermo Gonzalez on 24/01/16.
//  Copyright © 2016 Guillermo Gonzalez. All rights reserved.
//

import XCTest
@testable import Borders

class CountryTests: XCTestCase {
    
    func testJSONDecoding() {
        let dictionary: JSONDictionary = [
            "name": "Spain",
            "borders": ["AND", "FRA", "GIB", "PRT", "MAR"],
            "nativeName": "España"
        ]
        
        if let country: Country = decode(dictionary: dictionary) {
            XCTAssertEqual("Spain", country.name)
            XCTAssertEqual("España", country.nativeName)
            XCTAssertEqual(["AND", "FRA", "GIB", "PRT", "MAR"], country.borders)
        } else {
            XCTFail()
        }
    }
    
    func testInvalidJSONDecoding() {
        let dictionary: JSONDictionary = [
            "borders": ["AND", "FRA", "GIB", "PRT", "MAR"],
        ]
        
        let country: Country? = decode(dictionary: dictionary)
        XCTAssertNil(country)
    }
}
