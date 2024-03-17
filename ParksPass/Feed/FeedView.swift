// @copyright ParksPass by TrevisXcode

import SwiftUI
import ComposableArchitecture

@Reducer
struct Feed {
  @ObservableState
  struct State: Equatable {
    var text = "dd"
    var profileHeader = ProfileHeader.State()
    var feedCards: IdentifiedArrayOf<FeedCard.State> = [
      FeedCard.State(imageName: Asset.Image.onboarding1.rawValue),
      FeedCard.State(imageName: Asset.Image.onboarding2.rawValue),
      FeedCard.State(imageName: Asset.Image.onboarding3.rawValue),
    ]
  }
  
  enum Action: BindableAction {
    case binding(BindingAction<State>)
    case profileHeader(ProfileHeader.Action)
    case feedCards(IdentifiedActionOf<FeedCard>)
  }
  
  var body: some ReducerOf<Self> {
    Scope(state: \.profileHeader, action: \.profileHeader) {
      ProfileHeader()
    }.forEach(\.feedCards, action: \.feedCards) {
      FeedCard()
    }
  }
}

struct FeedView: View {
  @Bindable var store: StoreOf<Feed>
  @EnvironmentObject var vm: UserAuthModel
  
  var body: some View {
    NavigationView {
      VStack(spacing: .zero) {
        ProfileHeaderView(store: store.scope(state: \.profileHeader, action: \.profileHeader))
        ScrollView {
          VStack(spacing: 12) {
            ForEach(store.scope(state: \.feedCards, action: \.feedCards)) { store in
              FeedCardView(store: store)
            }
          }
        }
        .padding()
      }
    }
  }
}
