// @copyright ParksPass by TrevisXcode

import ComposableArchitecture
import SwiftUI
import Firebase
import GoogleSignIn

@main
struct ParksPassApp: App {
  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
  @StateObject var userAuth: UserAuthModel =  UserAuthModel()
  
  var body: some Scene {
    WindowGroup {
      OnboardingContainerView(store: Store(initialState: OnboardingContainer.State()) {
        OnboardingContainer()
      })
      .environmentObject(userAuth)
    }
  }
}

import SwiftUI
import FirebaseCore


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
  
  func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
    GIDSignIn.sharedInstance.handle(url)
  }
  
}
