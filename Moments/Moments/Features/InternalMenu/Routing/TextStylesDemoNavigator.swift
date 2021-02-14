//
//  TextStyleDemooNavigator.swift
//  Moments
//
//  Created by Jake Lin on 14/2/21.
//

import Foundation
import UIKit

struct TextStylesDemoNavigator: Navigating {
    func navigate(from viewController: UIViewController, using transitionType: TransitionType, parameters: [String: String]) {
        let togglesDataStore: TogglesDataStoreType = BuildTargetTogglesDataStore.shared
        guard togglesDataStore.isToggleOn(BuildTargetToggle.debug) || togglesDataStore.isToggleOn(BuildTargetToggle.internal) else {
            return
        }

        let destinationViewController = TextStylesDemoViewController()
        navigate(to: destinationViewController, from: viewController, using: transitionType)
    }
}
