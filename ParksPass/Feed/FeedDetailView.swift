// @copyright ParksPass by TrevisXcode

import SwiftUI
import MapKit
import ComposableArchitecture

@Reducer
struct FeedDetail {
  @ObservableState
  struct State {
    var article = Article()
    
    var locationCoordinate: CLLocationCoordinate2D {
      CLLocationCoordinate2D(latitude: article.latitude, longitude: article.longitude)
    }
    
    var region: MKCoordinateRegion {
      MKCoordinateRegion(
        center: locationCoordinate,
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
      )
    }
    
    var annotations: [Landmark] {
      [Landmark(coordinate: locationCoordinate)]
    }
  }
  
  enum Action: BindableAction {
    case binding(BindingAction<State>)
  }
  
  var body: some ReducerOf<Self> {
    BindingReducer()
  }
}

struct FeedDetailView: View {
  @Bindable var store: StoreOf<FeedDetail>
  
  var body: some View {
    GeometryReader { geometry in
      ScrollView {
        VStack {
          ImageBannerView(imageName: store.article.imageBanner, geometry: geometry)
          ParkSummaryTextView()
          MapView()
          ArticleContent(geometry: geometry)
        }
        .padding()
      }.navigationTitle(store.article.title)
    }
  }
  
  private func ImageBannerView(imageName: String, geometry: GeometryProxy) -> some View {
    Image(imageName)
      .resizable()
      .frame(width: geometry.size.width - 36, height: 220)
      .scaledToFill()
      .cornerRadius(20)
  }
  
  private func ParkSummaryTextView() -> some View {
    VStack(spacing: -4) {
      Text(store.article.title)
        .frame(maxWidth: .infinity, alignment: .leading)
        .font(.title2)
        .bold()
      
      Text(store.article.location)
        .frame(maxWidth: .infinity, alignment: .leading)
      
      Text(store.article.text1)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.top, 8)
    }
  }
  
  private func MapView() -> some View {
    Button {
      openInMaps(coordinate: CLLocationCoordinate2D(latitude: 33.8121, longitude: -117.9190))
    } label: {
      Map(coordinateRegion: .constant(store.region), interactionModes: [], annotationItems: store.annotations) { landmark in
        MapPin(coordinate: landmark.coordinate)
      }
      .frame(height: 180)
      .cornerRadius(20)
    }
  }
  
  func openInMaps(coordinate: CLLocationCoordinate2D) {
    let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate))
    mapItem.openInMaps(launchOptions: nil)
  }
  
  func ArticleContent(geometry: GeometryProxy) -> some View {
    VStack {
      Text(store.article.text2)
        .frame(maxWidth: .infinity, alignment: .leading)
      
      ImageBannerView(imageName: store.article.image1, geometry: geometry)
      
      Text(store.article.text3)
        .frame(maxWidth: .infinity, alignment: .leading)
      
      ImageBannerView(imageName: store.article.image2, geometry: geometry)
      Text(store.article.text4)
        .frame(maxWidth: .infinity, alignment: .leading)
      
      Color.gray.frame(height: 1)
  
      ImageBannerView(imageName: store.article.image3, geometry: geometry)
      
      Text(store.article.text5)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
  }
}

struct Landmark: Identifiable {
  let id = UUID()
  let coordinate: CLLocationCoordinate2D
}
