//
//  InternalMenuTextStylesDemoItemViewModel.swift
//  Moments
//
//  Created by Jake Lin on 14/2/21.
//

import Foundation

final class InternalMenuTextStylesDemoItemViewModel: InternalMenuActionTriggerItemViewModel {
    private let router: AppRouting
    private let routingSourceProvider: RoutingSourceProvider

    init(router: AppRouting, routingSourceProvider: @escaping RoutingSourceProvider) {
        self.router = router
        self.routingSourceProvider = routingSourceProvider
    }

    override var title: String {
        return L10n.InternalMenu.textStylesDemo
    }

    override func select() {
        // swiftlint:disable no_hardcoded_strings
        router.route(to: URL(string: "\(UniversalLinks.baseURL)TextStyles"), from: routingSourceProvider(), using: .show)
        // swiftlint:enable no_hardcoded_strings
    }
}
