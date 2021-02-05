//
//  DesignKitDemoItemViewModel.swift
//  Moments
//
//  Created by Jake Lin on 19/10/20.
//

import Foundation

final class InternalMenuDesignKitDemoItemViewModel: InternalMenuActionTriggerItemViewModel {
    private let router: AppRouting
    private let routingSourceProvider: RoutingSourceProvider

    init(router: AppRouting, routingSourceProvider: @escaping RoutingSourceProvider) {
        self.router = router
        self.routingSourceProvider = routingSourceProvider
    }

    override var title: String {
        return L10n.InternalMenu.designKitDemo
    }

    override func select() {
        // swiftlint:disable no_hardcoded_strings
        router.route(to: URL(string: "\(UniversalLinks.baseURL)DesignKit?productName=DesignKit&version=1.0.1"), from: routingSourceProvider(), using: .show)
        // swiftlint:enable no_hardcoded_strings
    }
}
