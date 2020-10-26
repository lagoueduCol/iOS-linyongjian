//
//  BaseTableViewCell.swift
//  Moments
//
//  Created by Jake Lin on 26/10/20.
//

import Foundation
import UIKit

class BaseTableViewCell<T: ListItemViewModel>: UITableViewCell, ListItemComponent {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
    }

    // swiftlint:disable unavailable_function
    required init?(coder: NSCoder) {
        fatalError(L10n.Development.fatalErrorInitCoderNotImplemented)
    }

    final func update(with viewModel: ListItemViewModel) {
        (viewModel as? T).map { update($0) }
    }

    // swiftlint:disable unavailable_function
    func update(_ viewModel: T) {
        fatalError(L10n.Development.fatalErrorSubclassToImplement)
    }
}
