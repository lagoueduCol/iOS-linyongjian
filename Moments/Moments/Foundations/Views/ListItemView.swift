//
//  ListItemView.swift
//  Moments
//
//  Created by Jake Lin on 27/10/20.
//

import Foundation
import UIKit

protocol ListItemView: class {
    associatedtype ViewModel
    func update(_ viewModel: ViewModel)
}

extension ListItemView where Self: UIView {
    // Implemented by conformed class
    // swiftlint:disable unavailable_function
    func update(_ viewModel: ViewModel) {
        fatalError(L10n.Development.fatalErrorSubclassToImplement)
    }
}
