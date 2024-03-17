// @copyright ParksPass by TrevisXcode

import ComposableArchitecture
import SwiftUI

@Reducer
struct Register {
  @ObservableState
  struct State: Equatable {
    var firstName: String = ""
    var lastName: String = ""
    var phoneNumber: String = ""
    var email: String = ""
    var password: String = ""
    var feed = Feed.State()
  }
  
  enum Action: BindableAction {
    case binding(BindingAction<State>)
    case feed(Feed.Action)
  }
  
  var body: some ReducerOf<Self> {
    BindingReducer()
    Scope(state: \.feed, action: \.feed) {
      Feed()
    }
  }
}


struct RegisterView: View {
  @Bindable var store: StoreOf<Register>
  @EnvironmentObject var sessionStore: SessionStore
  @State var profile: UserProfile?
  @State var showDetails = false
  
  var body: some View {
    VStack {
      Text("Create an Account")
        .font(.title)
        .padding(.top, 36)
      Text("Once registered, you can sign in and start exploring the Disneyland parks")
        .frame(maxWidth: .infinity, alignment: .center)
      TextField("First name", text: $store.firstName)
        .padding()
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .autocapitalization(.none)
        .keyboardType(.alphabet)
      TextField("Last name", text: $store.lastName)
        .padding()
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .autocapitalization(.none)
        .keyboardType(.alphabet)
      
      TextField("Phone number", text: $store.phoneNumber)
        .padding()
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .autocapitalization(.none)
        .keyboardType(.phonePad)
      
      TextField("Email", text: $store.email)
        .padding()
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .autocapitalization(.none)
        .keyboardType(.emailAddress)
      
      SecureField("Password", text: $store.password)
        .padding()
        .textFieldStyle(RoundedBorderTextFieldStyle())
      
      Spacer()
      // Login Button
      Button(action: {
        signUp()
      }) {
        Text("Sign Up")
          .frame(maxWidth: .infinity)
          .padding()
          .background(Color.blue)
          .foregroundColor(.white)
          .cornerRadius(24)
      }
      .padding(.horizontal, 40)
    }
    .padding()
    .fullScreenCover(isPresented: $sessionStore.isLoggedIn) {
      FeedView(store: store.scope(state: \.feed, action: \.feed))
    }
    
  }
  
  func signUp() {
    sessionStore.signUp(email: store.email, password: store.password, firstName: store.firstName, lastName: store.lastName, phoneNumber: store.phoneNumber) { (profile, error) in
      if let error = error {
        print("Error when signing up: \(error)")
        return
      }
    }
  }
  
}
