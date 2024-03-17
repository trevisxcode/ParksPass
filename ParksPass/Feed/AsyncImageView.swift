// @copyright ParksPass by TrevisXcode

import SwiftUI

struct AsyncImageView: View {
  var imageUrl: URL?
  
  var body: some View {
    if let imageUrl {
      AsyncImage(url: imageUrl) { phase in
        switch phase {
        case .empty:
          ProgressView()
        case .success(let imageView):
          imageView
            .resizable()
            .scaledToFill()
        default:
          placeholderImage
        }
      }
    } else {
      placeholderImage
    }
  }
  
  private var placeholderImage: some View {
    Image(systemName: "person.fill")
      .resizable()
      .aspectRatio(contentMode: .fit)
      .foregroundColor(.gray)
  }
}
