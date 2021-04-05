//
//  Functions.swift
//  Moments
//
//  Created by Jake Lin on 17/10/20.
//

import UIKit

func configure<T: AnyObject>(_ object: T, closure: (T) -> Void) -> T {
    closure(object)
    return object
}
