// @copyright ParksPass by TrevisXcode

import Foundation
import CoreData

class StorageContainer: ObservableObject {
  let container = NSPersistentContainer(name: "Parks")
  
  static let shared = StorageContainer()
  
  init() {
    container.loadPersistentStores { description, error in
      if let error = error {
        print("Core Data failed to load: \(error.localizedDescription)")
      }
    }
  }
  
  func loadElements() -> [Parks] {
    let viewContext = container.viewContext
    
    let fetchRequest = NSFetchRequest<Parks>(entityName: "Parks")
    do {
      let shows = try viewContext.fetch(fetchRequest)
      return shows
    } catch {
      print(error)
      return []
    }
  }
  
  func addElement(id: String, isVisited: Bool) {
    let entityToAdd = Parks(context: container.viewContext)
    entityToAdd.id = id
    entityToAdd.isVisited = isVisited
    
    save()
  }
  
  func update(parks: Parks) {
    save()
  }
  
  func save() {
    try? container.viewContext.save()
  }
}
