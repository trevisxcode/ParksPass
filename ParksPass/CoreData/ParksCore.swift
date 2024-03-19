// @copyright ParksPass by TrevisXcode

import Foundation

struct ParksCore {
  func addElement(id: String, isVisited: Bool) {
    StorageContainer.shared.addElement(id: id, isVisited: isVisited)
  }
}
