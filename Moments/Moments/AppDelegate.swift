//
//  AppDelegate.swift
//  Moments
//
//  Created by Jake Lin on 15/10/20.
//

import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        onLaunch()

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication,
                     configurationForConnecting connectingSceneSession: UISceneSession,
                     options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: L10n.Development.defaultConfiguration, sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running,
        // this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}

private extension AppDelegate {
    func onLaunch() {
        FirebaseApp.configure()

        // Can register multiple tracking providers here
        [FirebaseTrackingProvider()].forEach {
            TrackingRepo.shared.register(trackingProvider: $0)
        }

        // Can register different remote config provider here
        RemoteConfigRepo.shared.register(remoteConfigProvider: FirebaseRemoteConfigProvider())

        if BuildTargetTogglesDataStore.shared.isToggleOn(BuildTargetToggle.debug) {
            // There is still a bug in the Firebase Console, so the ID won't work until they fix it
            // https://github.com/firebase/firebase-ios-sdk/issues/6892#issuecomment-721795650
            Installations.installations().authTokenForcingRefresh(true) { token, error in
                // swiftlint:disable no_hardcoded_strings
                if let error = error {
                    print("Error fetching token: \(error)")
                    return
                }
                guard let token = token else { return }
                Installations.installations().installationID { id, _ in
                    print("Auth token: \(token.authToken)\nExpiration date: \(token.expirationDate)\nInstallation id: \(id ?? "invalid")")
                }
                // swiftlint:enable no_hardcoded_strings
            }
        }
    }
}

extension UIWindow {
    override open func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if BuildTargetTogglesDataStore.shared.isToggleOn(BuildTargetToggle.debug)
            || BuildTargetTogglesDataStore.shared.isToggleOn(BuildTargetToggle.internal) {
            let router: AppRouting = AppRouter()
            if motion == .motionShake {
                // swiftlint:disable no_hardcoded_strings
                TrackingRepo.shared.trackEvent(TrackingEvent(name: "shake", parameters: ["userID": UserDataStore.current.userID, "datetime": Date()]))
                // swiftlint:enable no_hardcoded_strings
                router.presentInternalMenu(from: rootViewController)
            }
        }
    }
}
