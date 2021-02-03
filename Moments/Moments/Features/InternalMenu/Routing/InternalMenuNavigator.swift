//
//  InternalMenuRoute.swift
//  Moments
//
//  Created by Jake Lin on 20/10/20.
//

import UIKit

struct InternalMenuNavigator: Navigating {
    func navigate(from viewController: UIViewController, using transitionType: TransitionType) {
        let destinationViewController = InternalMenuViewController()
        let router: AppRouting = AppRouter.shared
        let viewModel = InternalMenuViewModel(router: router, routingSource: destinationViewController)
        destinationViewController.viewModel = viewModel

        let navigationController = UINavigationController(rootViewController: destinationViewController)
        navigate(to: navigationController, from: viewController, using: transitionType)
    }
}
