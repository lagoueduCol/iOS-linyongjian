//
//  AppRouter.swift
//  Moments
//
//  Created by Jake Lin on 17/10/20.
//

import UIKit

protocol AppRouting {
    func presentInternalMenu(from viewController: UIViewController?)
}

struct AppRouter: AppRouting {
    func presentInternalMenu(from viewController: UIViewController?) {
        guard let fromViewController = viewController else { return }

        let viewController = InternalMenuViewController()
        let router = InternalMenuRouter(fromContronller: viewController)
        let viewModel = InternalMenuViewModel(router: router)
        viewController.viewModel = viewModel
        let navigationController = UINavigationController(rootViewController: viewController)
        fromViewController.present(navigationController, animated: true)
    }
}
