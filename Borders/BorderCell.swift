//
//  BorderCell.swift
//  Borders
//
//  Created by Guillermo Gonzalez on 24/01/16.
//  Copyright © 2016 Guillermo Gonzalez. All rights reserved.
//

import UIKit

class BorderCell: UITableViewCell, NibLoadableView {

    static let rowHeight: CGFloat = 54
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subtitleLabel: UILabel!
    
    var border: Border? {
        didSet {
            titleLabel.text = border?.name
            subtitleLabel.text = border?.nativeName
        }
    }
}
