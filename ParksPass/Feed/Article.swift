// @copyright ParksPass by TrevisXcode

import Foundation

struct Article: Equatable {
  var id: String = ""
  var imageBanner: String = ""
  var title: String = ""
  var location: String = ""
  var description: String = ""
  var latitude: Double = 0.0
  var longitude: Double = 0.0
  var text1: String = ""
  var text2: String = ""
  var text3: String = ""
  var text4: String = ""
  var text5: String = ""
  var image1: String = ""
  var image2: String = ""
  var image3: String = ""
}

extension Article {
  static let article1 = Article(
    id: "1",
    imageBanner: Asset.Image.article11.rawValue,
    title: "Disneyland Resort",
    location: "California, USA",
    description: "Disneyland Park in California, often just called Disneyland, is a world-famous theme park located in Anaheim, California. It was the first Disney theme park, opening on July 17, 1955.",
    latitude: 33.8121,
    longitude: -117.9190,
    text1: "Created by Walt Disney himself, the park is designed to bring fairy tales and Disney characters to life through various themed lands, rides, and attractions.",
    text2: "The park is divided into several distinct areas, each with its own unique theme: Main Street, U.S.A., Adventureland, Frontierland, Fantasyland, Tomorrowland, New Orleans Square, Critter Country, Mickey's Toontown, and Star Wars: Galaxy's Edge.",
    text3: "Iconic attractions include the Sleeping Beauty Castle, Pirates of the Caribbean, It's a Small World, and Space Mountain.",
    text4: "Disneyland is not just about rides; it offers a range of experiences such as parades, fireworks shows, character meet-and-greets, and live entertainment.",
    text5: "The park is known for its attention to detail, immersive environments, and exceptional customer service, making it a beloved destination for visitors of all ages from around the world.",
    image1: Asset.Image.article12.rawValue,
    image2: Asset.Image.article13.rawValue,
    image3: Asset.Image.article14.rawValue
  )
  
  static let article2 = Article(
    id: "2",
    imageBanner: Asset.Image.article21.rawValue,
    title: "Walt Disney World Resort",
    location: "Florida, USA",
    description: "Walt Disney World Resort in Florida is a sprawling entertainment complex that covers approximately 25,000 acres and is home to four iconic theme parks: Magic Kingdom, Epcot, Disney's Hollywood Studios, and Disney's Animal Kingdom.",
    latitude: 28.4177,
    longitude: -81.5812,
    text1: "Magic Kingdom: The first and most iconic park, Magic Kingdom, is known for its classic Disney attractions like Cinderella's Castle, Space Mountain, and Pirates of the Caribbean.",
    text2: "Epcot: Epcot is divided into two main sections: Future World and World Showcase. Future World focuses on technological advancements and innovation, with attractions like Spaceship Earth and Test Track.",
    text3: "Disney's Hollywood Studios: This park is themed around the glitz and glamour of Hollywood and the magic of movie-making. Attractions include the Twilight Zone Tower of Terror, Star Wars: Galaxy's Edge, and Toy Story Land.",
    text4: "Disney's Animal Kingdom: This park combines a traditional theme park with a zoo, offering both thrilling rides and animal encounters.",
    text5: "Each park at Walt Disney World Resort offers a unique experience, with countless attractions, shows, and dining options to explore.",
    image1: Asset.Image.article22.rawValue,
    image2: Asset.Image.article23.rawValue,
    image3: Asset.Image.article24.rawValue
  )
  
  static let article3 = Article(
    id: "3",
    imageBanner: Asset.Image.article31.rawValue,
    title: "Tokyo Disney Resort",
    location: "Tokyo, Japan",
    description: "Tokyo Disney Resort is a popular theme park resort located in Urayasu, Chiba, Japan, near Tokyo. It consists of two main theme parks: Tokyo Disneyland and Tokyo DisneySea.",
    latitude: 35.6345,
    longitude: 139.8804,
    text1: "Tokyo Disneyland: Opened in 1983 as the first Disney park outside the United States, Tokyo Disneyland follows a layout similar to Disneyland in California and Magic Kingdom in Florida.",
    text2: "The park offers a mix of classic Disney attractions like Cinderella's Castle, Pirates of the Caribbean, and Space Mountain, as well as unique attractions such as Pooh's Hunny Hunt and Monsters, Inc. Ride & Go Seek.",
    text3: "Tokyo DisneySea: Opened in 2001, Tokyo DisneySea is unique to Japan and is themed around nautical exploration, adventure, and different ports of call.",
    text4: "DisneySea is known for its elaborate theming and original attractions, such as Journey to the Center of the Earth, Tower of Terror, and Soaring: Fantastic Flight.",
    text5: "Tokyo Disney Resort offers a unique blend of Disney magic and Japanese culture, making it a must-visit destination for Disney fans and theme park enthusiasts from around the world.",
    image1: Asset.Image.article32.rawValue,
    image2: Asset.Image.article33.rawValue,
    image3: Asset.Image.article34.rawValue
  )
  
  static let article4 = Article(
    id: "4",
    imageBanner: Asset.Image.article41.rawValue,
    title: "Disneyland Paris",
    location: "Paris, France",
    description: "Disneyland Paris is a renowned theme park resort located in Marne-la-Vallée, a suburb of Paris, France. It consists of two main parks: Disneyland Park and Walt Disney Studios Park, along with several hotels, shopping districts, and dining areas.",
    latitude: 48.8703,
    longitude: 2.7792,
    text1: "Disneyland Park: Opened in 1992 as Euro Disneyland, this park is designed similarly to Disneyland in California and Magic Kingdom in Florida.",
    text2: "Iconic attractions include Sleeping Beauty Castle, Pirates of the Caribbean, Big Thunder Mountain, and Space Mountain. The park offers a blend of classic Disney magic and unique European influences.",
    text3: "Walt Disney Studios Park: Opened in 2002, this park is dedicated to show business, film, and behind-the-scenes aspects of movie-making.",
    text4: "The park offers immersive experiences and attractions based on popular Disney and Pixar movies.",
    text5: "Disneyland Paris provides a magical experience for visitors of all ages, combining the charm of Disney with the allure of Paris.",
    image1: Asset.Image.article42.rawValue,
    image2: Asset.Image.article43.rawValue,
    image3: Asset.Image.article44.rawValue
  )
  
  static let article5 = Article(
    id: "5",
    imageBanner: Asset.Image.article51.rawValue,
    title: "Disneyland Hong Kong",
    location: "Hong Kong",
    description: "Hong Kong Disneyland Resort is a magical theme park located on Lantau Island in Hong Kong. It is the smallest Disney park but offers a unique blend of Disney magic and Chinese culture.",
    latitude: 22.3129,
    longitude: 114.0413,
    text1: "Hong Kong Disneyland: The park opened in 2005 and consists of seven themed areas: Main Street, U.S.A., Fantasyland, Adventureland, Tomorrowland, Grizzly Gulch, Mystic Point, and Toy Story Land.",
    text2: "Each area offers a variety of attractions, entertainment, and dining options. Notable attractions include the iconic Sleeping Beauty Castle.",
    text3: "...which was transformed into the Castle of Magical Dreams in 2020, Mystic Manor, an innovative and unique take on the haunted house concept, and Big Grizzly Mountain Runaway Mine Cars, a thrilling roller coaster ride.",
    text4: "Hong Kong Disneyland is known for its intimate and easily navigable layout, making it an ideal destination for families with young children.",
    text5: "The park also celebrates traditional Chinese festivals, such as Chinese New Year and Mid-Autumn Festival, adding a local touch to the Disney experience.",
    image1: Asset.Image.article52.rawValue,
    image2: Asset.Image.article53.rawValue,
    image3: Asset.Image.article54.rawValue
  )
  
  static let article6 = Article(
    id: "6",
    imageBanner: Asset.Image.article61.rawValue,
    title: "Shanghai Disneyland",
    location: "Shanghai, China",
    description: "Shanghai Disney Resort is a world-class entertainment destination located in Pudong, Shanghai, China. Opened in 2016, it is the newest Disney theme park and the first in mainland China.",
    latitude: 31.1434,
    longitude: 121.6575,
    text1: "Shanghai Disneyland: The park features six themed lands: Mickey Avenue, Gardens of Imagination, Fantasyland, Adventure Isle, Treasure Cove, and Tomorrowland.",
    text2: "Each land offers unique attractions, entertainment, and dining experiences. Notable attractions include the Enchanted Storybook Castle, the largest Disney castle in the world",
    text3: "TRON Lightcycle Power Run, a high-speed roller coaster; and Pirates of the Caribbean: Battle for the Sunken Treasure, an innovative boat ride with advanced animatronics and multimedia effects.",
    text4: "Shanghai Disneyland is known for its fusion of classic Disney magic with Chinese culture and innovation.",
    text5: "The park offers a fresh and unique experience for visitors, with state-of-the-art attractions and immersive storytelling that set it apart from other Disney parks around the world.",
    image1: Asset.Image.article62.rawValue,
    image2: Asset.Image.article63.rawValue,
    image3: Asset.Image.article64.rawValue
  )
}
