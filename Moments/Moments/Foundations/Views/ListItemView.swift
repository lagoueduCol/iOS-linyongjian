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
    func update(with viewModel: ViewModel)
}
