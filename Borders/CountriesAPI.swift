//
//  CountriesAPI.swift
//  Borders
//
//  Created by Guillermo Gonzalez on 24/01/16.
//  Copyright © 2016 Guillermo Gonzalez. All rights reserved.
//

import Foundation
import RxSwift

enum CountriesAPI {
    case Name(name: String)
    case AlphaCodes(codes: [String])
}

extension CountriesAPI: Resource {
    
    var path: String {
        switch self {
        case let .Name(name):
            return "name/\(name)"
        case .AlphaCodes:
            return "alpha"
        }
    }
    
    var parameters: [String: String] {
        switch self {
        case .Name:
            return ["fullText": "true"]
        case let .AlphaCodes(codes):
            return ["codes": codes.joined(separator: ";")]
        }
    }
}

extension URL {
    static func countriesURL() -> URL {
        return URL(string: "https://restcountries.eu/rest/v1")!
    }
}

extension APIClient {
    class func countriesAPIClient() -> APIClient {
        return APIClient(baseURL: URL.countriesURL())
    }
    
    func countryWithName(name: String) -> Observable<Country> {
        return objects(resource: CountriesAPI.Name(name: name)).map { $0[0] }
    }
    
    func countriesWithCodes(codes: [String]) -> Observable<[Country]> {
        return objects(resource: CountriesAPI.AlphaCodes(codes: codes))
    }
}
