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
    func update(with item: InternalMenuItemViewModel) {
        (item as? T).map { update($0) }
    }

    // swiftlint:disable unavailable_function
    func update(_ item: T) {
        fatalError(L10n.Development.fatalErrorInitCoderNotImplemented)
    }
}
