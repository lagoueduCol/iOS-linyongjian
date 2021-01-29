//
//  InternalMenuActionTriggerCell.swift
//  Moments
//
//  Created by Jake Lin on 19/10/20.
//

import UIKit

class InternalMenuActionTriggerCell : InternalMenuCell<InternalMenuActionTriggerItemViewModel> {
    override func update(_ item: InternalMenuActionTriggerItemViewModel) {
        accessoryType = .disclosureIndicator
        textLabel?.text = item.title
    }
}
