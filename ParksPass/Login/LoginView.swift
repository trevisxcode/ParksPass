// @copyright ParksPass by TrevisXcode

import Foundation

import SwiftUI
import ComposableArchitecture

@Reducer
struct Login {
  @ObservableState
  struct State: Equatable {
    var text = "Login"
  }
  
  enum Action {
    case login
  }
}

struct LoginView: View {
  let store: StoreOf<Login>
  
  var body: some View {
    Text(store.text)
  }
}
