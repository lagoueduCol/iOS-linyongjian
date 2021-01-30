//
//  InternalMenuDescriptionCell.swift
//  Moments
//
//  Created by Jake Lin on 17/10/20.
//

import UIKit

class InternalMenuDescriptionCell: UITableViewCell, InternalMenuCellType {
    func update(with item: InternalMenuItemViewModel) {
        guard let item = item as? InternalMenuDescriptionItemViewModel else {
            return
        }

        selectionStyle = .none
        textLabel?.text = item.title
    }
}
