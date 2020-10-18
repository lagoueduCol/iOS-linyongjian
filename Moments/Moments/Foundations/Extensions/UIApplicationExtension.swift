//
//  UIApplicationExtension.swift
//  Moments
//
//  Created by Jake Lin on 18/10/20.
//

import UIKit

extension UIApplication {
    var rootViewController: UIViewController? {
        let keyWindow = connectedScenes
                .filter({ $0.activationState == .foregroundActive })
                .map({ $0 as? UIWindowScene })
                .compactMap({ $0 })
                .first?.windows
                .filter({ $0.isKeyWindow }).first
        return keyWindow?.rootViewController
    }
}
