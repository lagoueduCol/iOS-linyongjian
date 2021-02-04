//
//  DesignKitDemoNavigator.swift
//  Moments
//
//  Created by Jake Lin on 4/2/21.
//

import Foundation
import UIKit

struct DesignKitDemoNavigator: Navigating {
    func navigate(from viewController: UIViewController, using transitionType: TransitionType, parameters: [String: String]) {
        let togglesDataStore: TogglesDataStoreType = BuildTargetTogglesDataStore.shared
        guard togglesDataStore.isToggleOn(BuildTargetToggle.debug) || togglesDataStore.isToggleOn(BuildTargetToggle.internal) else {
            return
        }

        // swiftlint:disable no_hardcoded_strings
        guard let productName = parameters["productname"], let versionNumber = parameters["version"] else {
            return
        }
        // swiftlint:enable no_hardcoded_strings

        let destinationViewController = DesignKitDemoViewController(productName: productName, versionNumber: versionNumber)
        navigate(to: destinationViewController, from: viewController, using: transitionType)
    }
}
