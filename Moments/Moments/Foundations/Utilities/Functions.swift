//
//  InternalMenuViewModelType.swift
//  Moments
//
//  Created by Jake Lin on 17/10/20.
//

import UIKit

@discardableResult
func configure<T: AnyObject>(_ object: T, closure: (T) -> Void) -> T {
    closure(object)
    return object
}
