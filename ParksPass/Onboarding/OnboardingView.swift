// @copyright ParksPass by TrevisXcode

import ComposableArchitecture
import SwiftUI

struct OnboardingPage: Equatable {
  var image: String
  var text: String
  var buttonText: String
}

@Reducer
struct OnboardingReducer {
  @ObservableState
  struct State: Equatable {
    var selectedPage = 0
    let onboardingPages = [
      OnboardingPage(image: "page1Image", text: "Welcome to Page 1", buttonText: "Next"),
      OnboardingPage(image: "page2Image", text: "Welcome to Page 2", buttonText: "Next"),
      OnboardingPage(image: "page3Image", text: "Welcome to Page 3", buttonText: "Get Started")
    ]
    var login: Login.State?
  }
  
  enum Action {
    case nextButtonDidTap(Int)
    case selectPage(Int)
    case login(PresentationAction<Login.Action>)
  }
  
  var body: some Reducer<State, Action> {
    Reduce { state, action in
      switch action {
      case .nextButtonDidTap(let index):
        if index < state.onboardingPages.count - 1 {
          state.selectedPage += 1
        } else {
          state.login = Login.State()
        }
        return .none
      case .selectPage:
        return .none
      case .login:
        return .none
      }
    }
  }
}


struct OnboardingView: View {
  @AppStorage("isFirstAppLaunch") private var isFirstAppLaunch: Bool = true
  @Bindable var store: StoreOf<OnboardingReducer>
  
  var body: some View {
    TabView(selection: $store.selectedPage.sending(\.selectPage)) {
      ForEach(store.onboardingPages.indices, id: \.self) { index in
        VStack {
          Image(store.onboardingPages[index].image)
            .resizable()
            .scaledToFit()
            .padding()
          
          Text(store.onboardingPages[index].text)
          
          Button(store.onboardingPages[index].buttonText) {
            store.send(.nextButtonDidTap(index))
            if index == store.onboardingPages.count - 1 {
              isFirstAppLaunch = false
            }
          }
          .padding()
        }
        .tag(index)
      }
    }
    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
    .sheet(item: $store.scope(state: \.login, action: \.login)) { store in
      LoginView(store: store)
    }
  }
}
