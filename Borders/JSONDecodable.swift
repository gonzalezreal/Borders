//
//  JSONDecodable.swift
//  Borders
//
//  Created by Guillermo Gonzalez on 24/01/16.
//  Copyright © 2016 Guillermo Gonzalez. All rights reserved.
//

import Foundation

typealias JSONDictionary = [String: Any]

protocol JSONDecodable {
    init?(dictionary: JSONDictionary)
}

func decode<T: JSONDecodable>(dictionaries: [JSONDictionary]) -> [T] {
    return dictionaries.compactMap { T(dictionary: $0) }
}

func decode<T: JSONDecodable>(dictionary: JSONDictionary) -> T? {
    return T(dictionary: dictionary)
}

func decode<T:JSONDecodable>(data: Data) -> [T]? {
    guard let JSONObject = try? JSONSerialization.jsonObject(with: data, options: []),
        let dictionaries = JSONObject as? [JSONDictionary] else {
            return nil
    }
    
    return decode(dictionaries: dictionaries)
}
