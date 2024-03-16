// @copyright ParksPass by TrevisXcode

import ComposableArchitecture
import SwiftUI

struct OnboardingPage: Equatable {
  var image: String
  var text: String
  var subtitle: String
  var buttonText: String
}

@Reducer
struct OnboardingReducer {
  @ObservableState
  struct State: Equatable {
    var selectedPage = 0
    let onboardingPages = [
      OnboardingPage(
        image: Asset.Image.onboarding1.rawValue,
        text: "Welcome to ParksPass!",
        subtitle: "Your ultimate companion for exploring the magical world of Disneyland parks! Get ready to embark on a journey filled with enchantment and excitement!",
        buttonText: "Next"
      ),
      OnboardingPage(
        image: Asset.Image.onboarding2.rawValue,
        text: "Getting to know the park!",
        subtitle: "Dive into the details with ParkPass! Our app provides in-depth information about each Disneyland park, including attractions, entertainment, dining options, and more!",
        buttonText: "Next"
      ),
      OnboardingPage(
        image: Asset.Image.onboarding3.rawValue,
        text: "How close you are?",
        subtitle: "With ParkPass, you're always just a tap away from finding out how close you are to the magic! ParkPass keeps you informed and connected to the magic of Disneyland.",
        buttonText: "Get Started"
      )
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
        VStack(spacing: .zero) {
          Image(store.onboardingPages[index].image)
            .resizable()
            .aspectRatio(contentMode: .fill)
//            .cornerRadius(20)
            .edgesIgnoringSafeArea(.all)
//            .offset(y: 50)
          
          bottomCard(index: index)
            .offset(y: -54)
          
          Button {
            store.send(.nextButtonDidTap(index))
            if index == store.onboardingPages.count - 1 {
              isFirstAppLaunch = false
            }
          } label: {
            Text(store.onboardingPages[index].buttonText)
              .frame(height: 48)
              .frame(maxWidth: .infinity) // Set the minimum height to 48 and make the text fill the available width
              .background(Color.red) // Set the background color to red
              .foregroundColor(.white) // Set the text color to white
              .cornerRadius(20) // Set the corner radius to 20
          }.padding([.leading, .trailing, .bottom])
        }
        .tag(index)
      }
    }
    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
//    .sheet(item: $store.scope(state: \.login, action: \.login)) { store in
//      LoginView(store: store)
//    }
    .edgesIgnoringSafeArea(.all)
    .background(Color.black.edgesIgnoringSafeArea(.all))

  }
  
  private func bottomCard(index: Int) -> some View {
    VStack(spacing: 12) {
      Text(store.onboardingPages[index].text)
        .frame(maxWidth: .infinity, alignment: .center)
        .font(.title2)
        .fontWeight(.bold)
        .foregroundColor(.white)
        .padding(.top, 30)
      Text(store.onboardingPages[index].subtitle)
        .frame(maxWidth: .infinity, alignment: .leading)
        .foregroundColor(.white)
        .fixedSize(horizontal: false, vertical: true)
        .font(.callout)
      Spacer()
    }
    .padding([.trailing, .leading], 30)
    .background(Color.black.edgesIgnoringSafeArea(.all))
    .frame(height: 180)
    .cornerRadius(44, corners: [.topLeft, .topRight])
  }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
