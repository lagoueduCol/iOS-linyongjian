//
//  DesignKitDemoItemViewModel.swift
//  Moments
//
//  Created by Jake Lin on 19/10/20.
//

import Foundation

final class InternalMenuDesignKitDemoItemViewModel: InternalMenuActionTriggerItemViewModel {
    private let router: AppRouting
    private weak var routingSource: RoutingSource?

    init(router: AppRouting, routingSource: RoutingSource) {
        self.router = router
        self.routingSource = routingSource
    }

    deinit {
        routingSource = nil
    }

    override var title: String {
        return L10n.InternalMenu.designKitDemo
    }

    override func select() {
        // swiftlint:disable no_hardcoded_strings
        router.route(to: URL(string: "\(UniversalLinks.baseURL)DesignKit"), from: routingSource, using: .show)
        // swiftlint:enable no_hardcoded_strings
    }
}
