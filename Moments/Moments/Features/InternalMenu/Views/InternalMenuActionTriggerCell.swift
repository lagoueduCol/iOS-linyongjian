//
//  InternalMenuActionTriggerCell.swift
//  Moments
//
//  Created by Jake Lin on 19/10/20.
//

import UIKit

class InternalMenuActionTriggerCell: UITableViewCell, InternalMenuCellType {
    func update(with item: InternalMenuItemViewModel) {
        guard let item = item as? InternalMenuActionTriggerItemViewModel else {
            return
        }

        accessoryType = .disclosureIndicator
        textLabel?.text = item.title
    }
}
