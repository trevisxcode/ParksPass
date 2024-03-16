// @copyright ParksPass by TrevisXcode

import Foundation

import SwiftUI
import ComposableArchitecture

@Reducer
struct OnboardingContainer {
  @ObservableState
  struct State: Equatable {
    var onboarding = OnboardingReducer.State()
  }
  
  enum Action {
    case onboarding(OnboardingReducer.Action)
  }
  
  var body: some Reducer<State, Action> {
    Scope(state: \.onboarding, action: \.onboarding) {
      OnboardingReducer()
    }
  }
}

struct OnboardingContainerView: View {
  @AppStorage("isFirstAppLaunch") private var isFirstAppLaunch: Bool = true
  let store: StoreOf<OnboardingContainer>
  
  var body: some View {
    if isFirstAppLaunch {
      OnboardingView(store: store.scope(state: \.onboarding, action: \.onboarding))
        .onDisappear {
          isFirstAppLaunch = false
        }
    } else {
      MainView()
    }
  }
}

struct MainView: View {
  var body: some View {
    Text("Main App View")
  }
}
