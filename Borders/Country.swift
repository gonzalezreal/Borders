//
//  Country.swift
//  Borders
//
//  Created by Guillermo Gonzalez on 24/01/16.
//  Copyright © 2016 Guillermo Gonzalez. All rights reserved.
//

import Foundation

struct Country {
    let name: String
    let nativeName: String
    let borders: [String]
}

extension Country: JSONDecodable {
    init?(dictionary: JSONDictionary) {
        guard let name = dictionary["name"] as? String,
            let nativeName = dictionary["nativeName"] as? String else {
                return nil
        }
        
        self.name = name
        self.nativeName = nativeName
        self.borders = dictionary["borders"] as? [String] ?? []
    }
}
