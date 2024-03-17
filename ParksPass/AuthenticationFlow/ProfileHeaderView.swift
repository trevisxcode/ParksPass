// @copyright ParksPass by TrevisXcode

import SwiftUI
import ComposableArchitecture

@Reducer
struct ProfileHeader {
  @ObservableState
  struct State: Equatable {
    var text = ""
    var imageUrl: URL? = nil
    var isProfilePresented = false
    var isLoginPresented = false
    var isEmailProfilePresented = false
  }
  
  enum Action: BindableAction {
    case binding(BindingAction<State>)
    case viewIsReady(UserAuthModel)
    case viewForSessionStore(SessionStore)
    case profileDidTap
    case profileDidDismiss
    case loginDidTap
    case loginDidDismiss
    case signInDidTap
    case emailProfileDidTap
    case emailProfileDidDismiss
  }
  
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .binding: return .none
      case .profileDidTap:
        state.isProfilePresented = true
        return .none
      case .profileDidDismiss:
        state.isProfilePresented = false
        return .none
      case .emailProfileDidTap:
        state.isEmailProfilePresented = true
        return .none
      case .emailProfileDidDismiss:
        state.isEmailProfilePresented = false
        return .none
      case .loginDidTap:
        state.isLoginPresented = true
        return .none
      case .loginDidDismiss:
        state.isLoginPresented = false
        return .none
      case .signInDidTap: return .none
      case .viewIsReady(let userAuthModel):
        if userAuthModel.isLoggedIn {
          state.text = "Hey, \(userAuthModel.givenName)"
          state.imageUrl = URL(string: userAuthModel.profilePicUrl)
        } else {
          state.text = "ParksPass"
          state.imageUrl = nil
        }
        
        return .none
      case .viewForSessionStore(let sessionStore):
        guard state.imageUrl == nil else { return .none }
        
        if let profile = sessionStore.profile {
          state.text = "Hey, \(profile.firstName)"
          state.imageUrl = nil
        } else {
          state.text = "ParksPass"
          state.imageUrl = nil
        }
        
        return .none
      }
      
    }
  }
}

struct ProfileHeaderView: View {
  @Bindable var store: StoreOf<ProfileHeader>
  @EnvironmentObject var vm: UserAuthModel
  @EnvironmentObject var sessionStore: SessionStore

  var body: some View {
    VStack {
      HStack {
        Text(store.text)
          .fontWeight(.heavy)
          .foregroundColor(.black)
        
        Spacer()
        
        if let imageUrl = store.imageUrl {
          AsyncImageView(imageUrl: imageUrl)
            .frame(width: 44, height: 44)
            .clipShape(Circle())
            .onTapGesture {
              store.send(.profileDidTap)
            }
        } else {
          Image(systemName: "person.crop.circle")
            .resizable()
            .scaledToFill()
            .frame(width: 44, height: 44)
            .clipShape(Circle())
            .onTapGesture {
              store.send(.emailProfileDidTap)
            }
        }
      }.padding(.horizontal)
      
      Color.gray
        .frame(maxWidth: .infinity)
        .frame(height: 1)
    }.onAppear {
      store.send(.viewIsReady(vm))
      store.send(.viewForSessionStore(sessionStore))
    }
    .sheet(isPresented: $store.isProfilePresented, onDismiss: {
      store.send(.profileDidDismiss)
    }) {
      ProfileDetailView()
    }
    .sheet(isPresented: $store.isEmailProfilePresented, onDismiss: {
      store.send(.emailProfileDidDismiss)
    }) {
      EmailProfileDetailView()
    }
  }
}
