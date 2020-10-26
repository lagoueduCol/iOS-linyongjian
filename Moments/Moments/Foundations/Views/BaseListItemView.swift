//
//  BaseListItemView.swift
//  Moments
//
//  Created by Jake Lin on 27/10/20.
//

import Foundation
import UIKit

//class BaseListItemView<VM: ListItemViewModel>: UIView, ListItemView {
//    typealias ViewModel = VM
//}

class BaseListItemView<VM: ListItemViewModel>: UIView {
    // swiftlint:disable unavailable_function
    func update(_ viewModel: VM) {
        fatalError(L10n.Development.fatalErrorSubclassToImplement)
    }
}
