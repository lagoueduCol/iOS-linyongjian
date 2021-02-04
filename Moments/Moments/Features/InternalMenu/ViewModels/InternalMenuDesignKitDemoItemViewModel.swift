//
//  DesignKitDemoItemViewModel.swift
//  Moments
//
//  Created by Jake Lin on 19/10/20.
//

import Foundation

final class InternalMenuDesignKitDemoItemViewModel: InternalMenuActionTriggerItemViewModel {
    private let router: AppRouting
    private let routingSourceRetriever: RoutingSourceRetriever

    init(router: AppRouting, routingSourceRetriever: @escaping RoutingSourceRetriever) {
        self.router = router
        self.routingSourceRetriever = routingSourceRetriever
    }

    override var title: String {
        return L10n.InternalMenu.designKitDemo
    }

    override func select() {
        // swiftlint:disable no_hardcoded_strings
        router.route(to: URL(string: "\(UniversalLinks.baseURL)DesignKit"), from: routingSourceRetriever(), using: .show)
        // swiftlint:enable no_hardcoded_strings
    }
}
