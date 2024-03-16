// @copyright ParksPass by TrevisXcode

import ComposableArchitecture
import SwiftUI

@main
struct ParksPassApp: App {
  var body: some Scene {
    WindowGroup {
      OnboardingContainerView(store: Store(initialState: OnboardingContainer.State()) {
        OnboardingContainer()
      })
    }
  }
}
