//
//  InternalMenuFeatureToggleCell.swift
//  Moments
//
//  Created by Jake Lin on 31/10/20.
//

import Foundation
import UIKit

class InternalMenuFeatureToggleCell: InternalMenuCell<InternalMenuFeatureToggleItemViewModel> {
    var item: InternalMenuFeatureToggleItemViewModel?

    private let switchControl: UISwitch = configure(.init()) {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none
        accessoryView = switchControl
        switchControl.addTarget(self, action: #selector(toggleSwitch), for: .valueChanged)
    }

    // swiftlint:disable unavailable_function
    required init?(coder: NSCoder) {
        fatalError(L10n.Development.fatalErrorInitCoderNotImplemented)
    }

    @objc
    func toggleSwitch() {
        if switchControl.isOn {
            item?.toggleOn()
        } else {
            item?.toggleOff()
        }
    }
}
