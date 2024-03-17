// @copyright ParksPass by TrevisXcode

import SwiftUI
import ComposableArchitecture

@Reducer
struct ProfileHeader {
  @ObservableState
  struct State: Equatable {
    var text = "dd"
  }
}

struct ProfileHeaderView: View {
  @Bindable var store: StoreOf<ProfileHeader>
  @EnvironmentObject var vm: UserAuthModel
  
  var body: some View {
    VStack {
      HStack {
        Text("Hey, \(vm.givenName)")
        Spacer()
        AsyncImageView(imageUrl: URL(string: vm.profilePicUrl))
          .frame(width: 44, height: 44)
          .clipShape(Circle())
      }.padding(.horizontal)
      
      Color.gray
        .frame(maxWidth: .infinity)
        .frame(height: 1)
    }
  }
}
