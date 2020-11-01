//
//  InternalMenuDescriptionCell.swift
//  Moments
//
//  Created by Jake Lin on 17/10/20.
//

import UIKit

class InternalMenuDescriptionCell : InternalMenuCell<InternalMenuDescriptionItemViewModel> {
    override func update(_ item: InternalMenuDescriptionItemViewModel) {
        selectionStyle = .none
        textLabel?.text = item.title
    }
}
