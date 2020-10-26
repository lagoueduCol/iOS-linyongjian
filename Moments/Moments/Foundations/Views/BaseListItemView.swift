//
//  BaseListItemView.swift
//  Moments
//
//  Created by Jake Lin on 27/10/20.
//

import Foundation
import UIKit

class BaseListItemView<VM: ListItemViewModel>: UIView, ListItemView {
    typealias ViewModel = VM
}
