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
        let routingSourceRetriever = { [weak destinationViewController] in
            destinationViewController } // Remember to weak the `viewController` to avoid retain cycle
        let viewModel = InternalMenuViewModel(router: router, routingSourceRetriever: routingSourceRetriever)
        destinationViewController.viewModel = viewModel

        let navigationController = UINavigationController(rootViewController: destinationViewController)
        navigate(to: navigationController, from: viewController, using: transitionType)
    }
}
