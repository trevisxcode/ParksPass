// @copyright ParksPass by TrevisXcode

import SwiftUI

struct FeedView: View {
  @EnvironmentObject var vm: UserAuthModel
  
  fileprivate func ProfilePic() -> some View {
    AsyncImage(url: URL(string: vm.profilePicUrl))
      .frame(width: 200, height: 200)
      .clipShape(Circle())
  }
  
  fileprivate func UserInfo() -> Text {
    return Text(vm.givenName)
  }
  
  var body: some View {
    VStack{
      UserInfo()
      ProfilePic()
    }.navigationTitle("ParksPass")
  }
}

#Preview {
  FeedView()
}
