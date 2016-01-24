//
//  BordersViewModel.swift
//  Borders
//
//  Created by Guillermo Gonzalez on 24/01/16.
//  Copyright © 2016 Guillermo Gonzalez. All rights reserved.
//

import Foundation
import RxSwift

typealias Border = (name: String, nativeName: String)

protocol BordersViewModelType: class {
    
    /// The name of the country
    var countryName: String { get }
    
    /// The corresponding borders
    var borders: Observable<[Border]> { get }
}

class BordersViewModel: BordersViewModelType {
    
    let countryName: String
    
    private(set) lazy var borders: Observable<[Border]> = Observable.just([
        ("Austria", "Österreich"),
        ("France", "France"),
        ("Germany", "Deutschland")
        ])
    
    init(countryName: String) {
        self.countryName = countryName
    }
}
