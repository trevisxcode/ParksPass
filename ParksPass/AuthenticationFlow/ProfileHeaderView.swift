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
  }
  
  enum Action: BindableAction {
    case binding(BindingAction<State>)
    case viewIsReady(UserAuthModel)
    case profileDidTap
    case profileDidDismiss
    case loginDidTap
    case loginDidDismiss
    case signInDidTap
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
      }
    }
  }
}

struct ProfileHeaderView: View {
  @Bindable var store: StoreOf<ProfileHeader>
  @EnvironmentObject var vm: UserAuthModel
  
  var body: some View {
    VStack {
      HStack {
        Text(store.text)// "Hey, \(vm.givenName)")
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
              store.send(.loginDidTap)
            }
        }
      }.padding(.horizontal)
      
      Color.gray
        .frame(maxWidth: .infinity)
        .frame(height: 1)
    }.onAppear {
      store.send(.viewIsReady(vm))
    }
    .sheet(isPresented: $store.isProfilePresented, onDismiss: {
      store.send(.profileDidDismiss)
    }) {
      ProfileDetailView()
    }
    .sheet(isPresented: $store.isLoginPresented, onDismiss: {
      store.send(.loginDidDismiss)
    }) {
      LoginView(store: Store(initialState: Login.State()) {
        Login()
      })
    }
  }
}
