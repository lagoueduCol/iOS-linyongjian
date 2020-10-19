//
//  DesignKitDemoItemViewModel.swift
//  Moments
//
//  Created by Jake Lin on 19/10/20.
//

import Foundation

final class DesignKitDemoItemViewModel: InternalMenuActionTriggerItemViewModel {

    private let router: InternalMenuRouting

    init(router: InternalMenuRouting) {
        self.router = router
    }

    override var title: String {
        return "DesignKit Demo"
    }

    override func select() {
        router.showDesignKit()
    }
}
