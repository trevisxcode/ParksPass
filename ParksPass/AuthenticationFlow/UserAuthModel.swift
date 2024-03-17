// @copyright ParksPass by TrevisXcode

import SwiftUI
import Firebase
import GoogleSignIn

class UserAuthModel: ObservableObject {
  
  @Published var givenName: String = ""
  @Published var fullName: String = ""
  @Published var profilePicUrl: String = ""
  @Published var isLoggedIn: Bool = false
  @Published var errorMessage: String = ""
  
  init() {
    GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
      if let error = error {
        self.errorMessage = "error: \(error.localizedDescription)"
      }
      
      self.checkStatus()
    }
  }
  
  func checkStatus() {
    if let user = GIDSignIn.sharedInstance.currentUser {
      let givenName = user.profile?.givenName ?? ""
      let familyName = user.profile?.familyName ?? ""
      let profilePicUrl = user.profile!.imageURL(withDimension: 100)!.absoluteString
      self.givenName = givenName
      self.fullName = "\(givenName) \(familyName)"
      self.profilePicUrl = profilePicUrl
      self.isLoggedIn = true
    } else {
      self.isLoggedIn = false
      self.givenName = "Not Logged In"
      self.profilePicUrl = ""
      self.fullName = ""
    }
  }
  
  func signIn() {
    guard
      let firstScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
      let presentingViewController = firstScene.windows.first?.rootViewController,
      let clientId = FirebaseApp.app()?.options.clientID
    else { return }
        
    GIDSignIn.sharedInstance.configuration = GIDConfiguration(clientID: clientId)
    GIDSignIn.sharedInstance.signIn(
      withPresenting: presentingViewController
    ) { [weak self] signInResult, error in
      guard let self = self else { return }
      
      if let error = error {
        self.errorMessage = "error: \(error.localizedDescription)"
      }
      
      self.checkStatus()
    }
  }
  
  func signOut() {
    GIDSignIn.sharedInstance.signOut()
    checkStatus()
  }
}
