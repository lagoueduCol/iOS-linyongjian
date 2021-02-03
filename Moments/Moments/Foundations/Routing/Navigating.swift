//
//  Navigating.swift
//  Moments
//
//  Created by Jake Lin on 3/2/21.
//

import Foundation
import UIKit

protocol Navigating {
    func navigate(from viewController: UIViewController, using transitionType: TransitionType)
}

extension Navigating {
    func navigate(to destinationViewController: UIViewController, from sourceViewController: UIViewController, using transitionType: TransitionType) {
        switch transitionType {
        case .show:
            sourceViewController.show(destinationViewController, sender: sourceViewController)
        case .present:
            sourceViewController.present(destinationViewController, animated: true)
        }
    }
}
