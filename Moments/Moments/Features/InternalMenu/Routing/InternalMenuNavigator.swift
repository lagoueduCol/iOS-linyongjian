//
//  InternalMenuRoute.swift
//  Moments
//
//  Created by Jake Lin on 20/10/20.
//

import UIKit

struct InternalMenuNavigator: Navigating {
    func navigate(from viewController: UIViewController, using transitionType: TransitionType, parameters: [String : String]) {
        let togglesDataStore: TogglesDataStoreType = BuildTargetTogglesDataStore.shared
        guard togglesDataStore.isToggleOn(BuildTargetToggle.debug) || togglesDataStore.isToggleOn(BuildTargetToggle.internal) else {
            return
        }

        let navigationController = UINavigationController(rootViewController: InternalMenuViewController())
        navigate(to: navigationController, from: viewController, using: transitionType)
    }
}
