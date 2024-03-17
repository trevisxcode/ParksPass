// @copyright ParksPass by TrevisXcode

import ComposableArchitecture
import SwiftUI

@Reducer
struct Register {
  @ObservableState
  struct State: Equatable {
    var fullname: String = ""
    var phoneNumber: String = ""
    var email: String = ""
    var password: String = ""
  }
  
  enum Action: BindableAction {
    case binding(BindingAction<State>)
  }
}


struct RegisterView: View {
  @Bindable var store: StoreOf<Register>

  var body: some View {
    VStack {
      Text("Create an Account")
        .font(.title)
        .padding(.top, 36)
      Text("Once registered, you can sign in and start exploring the Disneyland parks")
        .frame(maxWidth: .infinity, alignment: .center)
      TextField("Full name", text: $store.fullname)
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
        // Perform login action
      }) {
        Text("Sign Up")
          .frame(maxWidth: .infinity)
          .padding()
          .background(Color.blue)
          .foregroundColor(.white)
          .cornerRadius(24)
      }
      .padding(.horizontal, 40)
      
      Text("Or")
        .font(.caption)
      
      // Sign in with Google Button
      Button(action: {
        // Perform Google sign-in action
      }) {
        Text("Sign up with Google")
          .frame(maxWidth: .infinity)
          .padding()
          .background(Color.red)
          .foregroundColor(.white)
          .cornerRadius(24)
      }
      .padding(.horizontal, 40)
      
    }
    .padding()
  }
}

//struct RegisterView_Previews: PreviewProvider {
//  static var previews: some View {
//    RegisterView()
//  }
//}

//

