// @copyright ParksPass by TrevisXcode

import SwiftUI
import ComposableArchitecture

struct EmailProfileDetailView: View {
  @EnvironmentObject var sessionStore: SessionStore
  @State var isPresented = false

  var body: some View {
    VStack {
      Image(systemName: "person.crop.circle")
        .resizable()
        .scaledToFill()
        .frame(width: 44, height: 44)
        .clipShape(Circle())
        .padding(.top, 48)
      Text("\(sessionStore.profile?.firstName ?? "") \(sessionStore.profile?.lastName ?? "")")
        .font(.title3)
      Spacer()
      Button {
        sessionStore.signOut()
      } label: {
        Text("Sign Out")
      }
    }
  }
}
