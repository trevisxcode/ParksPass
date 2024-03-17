// @copyright ParksPass by TrevisXcode

import SwiftUI
import ComposableArchitecture

@Reducer
struct FeedCard {
  @ObservableState
  struct State: Equatable, Identifiable {
    var id: String { imageName }
    var imageName = Asset.Image.onboarding1.rawValue
    var title = ""
    var subtitle = ""
  }
}

struct FeedCardView: View {
  
  @Bindable var store: StoreOf<FeedCard>
//  var viewModel: Model
  @State var isPresented = false
  
  var body: some View {
    NavigationLink(destination: Text("TT")) {
      Content()
    }
    .buttonStyle(ScaledButtonStyle())
  }
  
  func Content() -> some View {
    ZStack(alignment: .bottomLeading) {
      Image(store.imageName)
        .resizable()
        .aspectRatio(contentMode: .fill)
        .frame(height: 200)
        .overlay(
          LinearGradient(
            gradient: Gradient(colors: [Color.black, .clear, .clear, .clear]),
            startPoint: .bottom,
            endPoint: .top
          )
          .opacity(Constant.opacity)
        )
        .clipped()
      
      VStack(spacing: -4) {
        Text(store.title)
          .font(.title2)
          .bold()
          .frame(maxWidth: .infinity, alignment: .leading)
        
        Text(store.subtitle)
          .frame(maxWidth: .infinity, alignment: .leading)
      }
      .foregroundColor(.white)
      .padding(.horizontal, 24)
      .padding(.bottom, 18)
    }
    .cornerRadius(Constant.cornerRadius)
  }
}

extension FeedCardView {
  struct Constant {
    static var spacing: CGFloat = 12
    static var padding: CGFloat = 20
    static var subPadding: CGFloat = 14
    static var opacity: CGFloat = 0.9
    static var height: CGFloat = 200
    static var sumSpacing: CGFloat = padding + (spacing / 2)
    static var cornerRadius: CGFloat = 28
  }
}

#Preview {
  FeedCardView(store: Store(initialState: FeedCard.State()) {
    FeedCard()
  })
}

struct ScaledButtonStyle: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .scaleEffect(configuration.isPressed ? 0.94 : 1)
      .animation(.easeInOut, value: configuration.isPressed)
  }
}
