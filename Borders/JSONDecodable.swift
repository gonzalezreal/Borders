//
//  JSONDecodable.swift
//  Borders
//
//  Created by Guillermo Gonzalez on 24/01/16.
//  Copyright © 2016 Guillermo Gonzalez. All rights reserved.
//

import Foundation

typealias JSONDictionary = [String: AnyObject]

protocol JSONDecodable {
    init?(dictionary: JSONDictionary)
}

func decode<T: JSONDecodable>(dictionaries: [JSONDictionary]) -> [T] {
    return dictionaries.flatMap { T(dictionary: $0) }
}

func decode<T: JSONDecodable>(dictionary: JSONDictionary) -> T? {
    return T(dictionary: dictionary)
}

func decode<T:JSONDecodable>(data: NSData) -> [T]? {
    guard let JSONObject = try? NSJSONSerialization.JSONObjectWithData(data, options: []),
        dictionaries = JSONObject as? [JSONDictionary],
        objects: [T] = decode(dictionaries) else {
            return nil
    }
    
    return objects
}
