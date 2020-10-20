//
//  Avatar.swift
//  DesignKit
//
//  Created by Jake Lin on 20/10/20.
//

import UIKit

public extension UIImageView {
    func asAvatar() {
        clipsToBounds = true
        layer.cornerRadius = 2
    }
}
