// @copyright ParksPass by TrevisXcode

import SwiftUI
import Firebase
import GoogleSignIn

class UserAuthModel: ObservableObject {
  
  @Published var givenName: String = ""
  @Published var profilePicUrl: String = ""
  @Published var isLoggedIn: Bool = false
  @Published var errorMessage: String = ""
  
  init(){
    check()
  }
  
  func checkStatus(){
    if(GIDSignIn.sharedInstance.currentUser != nil){
      let user = GIDSignIn.sharedInstance.currentUser
      guard let user = user else { return }
      let givenName = user.profile?.givenName
      let profilePicUrl = user.profile!.imageURL(withDimension: 100)!.absoluteString
      self.givenName = givenName ?? ""
      self.profilePicUrl = profilePicUrl
      self.isLoggedIn = true
    }else{
      self.isLoggedIn = false
      self.givenName = "Not Logged In"
      self.profilePicUrl =  ""
    }
  }
  
  func check(){
    GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
      if let error = error {
        self.errorMessage = "error: \(error.localizedDescription)"
      }
      
      self.checkStatus()
    }
  }
  
  func signIn(){
    
    guard 
      let presentingViewController = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.rootViewController
//      let clientId = FirebaseApp.app()?.options.clientID
    else { return }
    
    guard let clientID = FirebaseApp.app()?.options.clientID else { return }
    
    let config = GIDConfiguration(clientID: clientID)
    GIDSignIn.sharedInstance.configuration = config


//    let signInConfig = GIDConfiguration.init(clientID: clientId)
    GIDSignIn.sharedInstance.signIn(
      withPresenting: presentingViewController
    ) { [weak self] signInResult, error in
      guard let self = self else { return }

      if let error = error {
        self.errorMessage = "error: \(error.localizedDescription)"
      }
      self.checkStatus()
    }
//    GIDSignIn.sharedInstance.signIn(
//      with: signInConfig,
//      presenting: presentingViewController,
//      callback: { user, error in
//        if let error = error {
//          self.errorMessage = "error: \(error.localizedDescription)"
//        }
//        self.checkStatus()
//      }
//    )
  }
  
  func signOut(){
    GIDSignIn.sharedInstance.signOut()
    self.checkStatus()
  }
}
