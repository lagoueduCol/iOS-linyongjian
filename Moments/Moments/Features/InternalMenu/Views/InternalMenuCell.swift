//
//  InternalMenuCell.swift
//  Moments
//
//  Created by Jake Lin on 17/10/20.
//

import UIKit

protocol InternalMenuItemViewing {
    func update(with item: InternalMenuItemViewModel)
}

class InternalMenuCell<T: InternalMenuItemViewModel> : UITableViewCell, InternalMenuItemViewing {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func update(with item: InternalMenuItemViewModel) {
        (item as? T).map { update($0) }
    }

    func update(_ item: T) {
        fatalError("Subclass has to implement this function")
    }
}
