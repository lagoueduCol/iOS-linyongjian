//
//  DesignKitDemoNavigator.swift
//  Moments
//
//  Created by Jake Lin on 4/2/21.
//

import Foundation
import UIKit

struct DesignKitDemoNavigator: Navigating {
    func navigate(from viewController: UIViewController, using transitionType: TransitionType) {
        let destinationViewController = DesignKitDemoViewController()
        navigate(to: destinationViewController, from: viewController, using: transitionType)
    }
}
