//
//  GreenWorldApp.swift
//  GreenWorld
//
//  Created by ChaimaEljed on 27/11/2023.
//

import SwiftUI
import FBSDKCoreKit


class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        return true
    }
}
@main
struct GreenWorldApp: App {
    let persistenceController = PersistenceController.shared
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            GestionUserSignIn()
               
        }
    }
}
