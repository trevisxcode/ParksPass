// @copyright ParksPass by TrevisXcode

import Foundation
import Combine
import Firebase

class SessionStore: ObservableObject {
  @Published var session: User?
  @Published var profile: UserProfile?
  @Published var isLoggedIn: Bool = false
  
  
  private var profileRepository = UserProfileRepository()
  
  func signUp(email: String, password: String, firstName: String, lastName: String, phoneNumber: String, completion: @escaping (_ profile: UserProfile?, _ error: Error?) -> Void) {
    Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
      if let error = error {
        print("Error signing up: \(error)")
        completion(nil, error)
        return
      }
      
      guard let user = result?.user else { return }
      print("User \(user.uid) signed up.")
      
      let userProfile = UserProfile(uid: user.uid, firstName: firstName, lastName: lastName, phoneNumber: phoneNumber)
      self.profileRepository.createProfile(profile: userProfile) { (profile, error) in
        if let error = error {
          print("Error while fetching the user profile: \(error)")
          completion(nil, error)
          return
        }
        self.profile = profile
        self.isLoggedIn = true
        completion(profile, nil)
      }
    }
  }
  
  func signIn(email: String, password: String, completion: @escaping (_ profile: UserProfile?, _ error: Error?) -> Void) {
    Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
      if let error = error {
        print("Error signing in: \(error)")
        completion(nil, error)
        return
      }
      
      guard let user = result?.user else { return }
      print("User \(user.uid) signed in.")
      
      self.profileRepository.fetchProfile(userId: user.uid) { (profile, error) in
        if let error = error {
          print("Error while fetching the user profile: \(error)")
          completion(nil, error)
          return
        }
        
        self.profile = profile
        self.isLoggedIn = true
        completion(profile, nil)
      }
    }
  }
  
  func signOut() {
    do {
      try Auth.auth().signOut()
      self.session = nil
      self.profile = nil
      self.isLoggedIn = false
    }
    catch let signOutError as NSError {
      print("Error signing out: \(signOutError)")
    }
  }
}

struct User {
  var uid: String
  var email: String?
  
  init(uid: String, email: String?) {
    self.uid = uid
    self.email = email
  }
}
