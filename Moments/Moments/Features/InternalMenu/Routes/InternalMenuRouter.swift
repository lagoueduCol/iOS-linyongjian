//
//  InternalMenuRoute.swift
//  Moments
//
//  Created by Jake Lin on 20/10/20.
//

import UIKit

protocol InternalMenuRouting {
    func showDesignKit()
}

struct InternalMenuRouter: InternalMenuRouting {
    weak var fromContronller: UIViewController?

    init(fromContronller: UIViewController?) {
        self.fromContronller = fromContronller
    }

    func showDesignKit() {
    }
}
