// @copyright ParksPass by TrevisXcode

import SwiftUI
import ComposableArchitecture

@Reducer
struct Login {
  @ObservableState
  struct State: Equatable {
    var email = ""
    var password = ""
    var register = Register.State()
    var feed = Feed.State()
  }
  
  enum Action: BindableAction {
    case binding(BindingAction<State>)
    case login
    case register(Register.Action)
    case feed(Feed.Action)
  }
  
  var body: some ReducerOf<Self> {
    BindingReducer()
    Scope(state: \.register, action: \.register) {
      Register()
    }
    Scope(state: \.feed, action: \.feed) {
      Feed()
    }
    Reduce { state, action in
      switch action {
      case .binding(_): return .none
      case .login: return .none
      case .register(_): return .none
      case .feed: return .none
      }
    }
  }
}

struct LoginView: View {
  @Bindable var store: StoreOf<Login>
  @EnvironmentObject var vm: UserAuthModel
  @EnvironmentObject var sessionStore: SessionStore
  
  var body: some View {
    container
  }
  
  private var container: some View {
    VStack {
      Text("Sign In")
        .font(.title)
        .padding(.top, 36)
      Text("Log in and access your personalized ParkPass experience")
        .frame(maxWidth: .infinity, alignment: .center)
      TextField("Email", text: $store.email)
        .padding()
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .autocapitalization(.none)
        .keyboardType(.emailAddress)
      
      SecureField("Password", text: $store.password)
        .padding()
        .textFieldStyle(RoundedBorderTextFieldStyle())
      
      Spacer()
      Button(action: {
        signIn()
      }) {
        Text("Login")
          .frame(maxWidth: .infinity)
          .padding()
          .background(Color.blue)
          .foregroundColor(.white)
          .cornerRadius(24)
      }
      .padding(.horizontal, 40)
      
      Text("Or")
        .font(.caption)
      
      Button(action: {
        vm.signIn()
      }) {
        Text("Sign in with Google")
          .frame(maxWidth: .infinity)
          .padding()
          .background(Color.red)
          .foregroundColor(.white)
          .cornerRadius(24)
      }
      .padding(.horizontal, 40)
      
      NavigationLink(
        destination: RegisterView(
          store: store.scope(state: \.register, action: \.register)
        )
      ) {
        Text("Don't have an account? Sign up")
          .frame(maxWidth: .infinity)
          .padding(.horizontal, 40)
      }
    }
    .padding()
    .fullScreenCover(isPresented: $vm.isLoggedIn) {
      FeedView(store: store.scope(state: \.feed, action: \.feed))
    }
    
    .fullScreenCover(isPresented: $sessionStore.isLoggedIn) {
      FeedView(store: store.scope(state: \.feed, action: \.feed))
    }
  }
  
  func signIn() {
    sessionStore.signIn(email: store.email, password: store.password) { (profile, error) in
      if let error = error {
        print("Error when signing up: \(error)")
        return
      }
    }
  }
  
}
