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
    static var instance: AppRouter = {
        return AppRouter()
    }()

    private init() { }

    func presentInternalMenu(from viewController: UIViewController?) {
        guard let fromViewController = viewController else { return }

        let viewModel = InternalMenuViewModel(appRouter: self)
        let viewController = InternalMenuViewController(viewModel: viewModel)
        let navigationController = UINavigationController(rootViewController: viewController)
        fromViewController.present(navigationController, animated: true)
    }
}
