// @copyright ParksPass by TrevisXcode

import SwiftUI

struct ProfileDetailView: View {
  @EnvironmentObject var vm: UserAuthModel

  var body: some View {
    VStack {
      AsyncImageView(imageUrl: URL(string: vm.profilePicUrl))
        .frame(width: 100, height: 100)
        .clipShape(Circle())
        .padding(.top, 48)
      Text(vm.fullName)
        .font(.title3)
      Spacer()
      Button {
        vm.signOut()
      } label: {
        Text("Sign Out")
      }
    }
  }
}

#Preview {
  ProfileDetailView()
}
