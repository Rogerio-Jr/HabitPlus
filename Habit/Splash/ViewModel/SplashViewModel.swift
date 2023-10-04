//
//  SplashViewModel.swift
//  Habit
//
//  Created by Rogério Júnior on 31/01/23.
//

import SwiftUI
import Combine

class SplashViewModel: ObservableObject {
  
  @Published var uiState: SplashUIState = .loading
  
  private var cancellableAuth: AnyCancellable?
  private var cancellableRefresh: AnyCancellable?

  private let interactor: SplashInteractor
  
  init(interactor: SplashInteractor) {
    self.interactor = interactor
  }
  
  deinit {
    cancellableAuth?.cancel()
    cancellableRefresh?.cancel()
  }
  
  func onAppear() {
    cancellableAuth = interactor.fetchAuth()
      .delay(for: .seconds(2), scheduler: RunLoop.main)
      .receive(on: DispatchQueue.main)
      .sink { userAuth in
    
        if userAuth == nil {
            self.uiState = .goToSingInScreen
        }
       
          else if (Date().timeIntervalSince1970 > Double(userAuth!.expires)) {
            // chamar o refresh token na API
            print("token expirou")
            let reqeuest = RefreshRequest(token: userAuth!.refreshToken)
            self.cancellableRefresh = self.interactor.refreshToken(refreshRequest: reqeuest)
              .receive(on: DispatchQueue.main)
              .sink(receiveCompletion: { completion in
                switch(completion) {
                  case .failure(_):
                    self.uiState = .goToSingInScreen
                    break
                  default:
                    break
                }
              }, receiveValue: { success in
                
                let auth = UserAuth(idToken: success.accessToken,
                                    refreshToken: success.refreshToken,
                                    expires: Date().timeIntervalSince1970 + Double(success.expires),
                                    tokenType: success.tokenType)
                
                self.interactor.insertAuth(userAuth: auth)
                
                self.uiState = .goToHomeScreen
                
              })
          }
          // senao -> Tela princial
          else {
            self.uiState = .goToHomeScreen
          }
        }
    }
    
  }


extension SplashViewModel {
  func signInView() -> some View {
    return SplashViewRouter.makeSingInView()
  }
    
    func homeView() -> some View {
        return SplashViewRouter.makeHomeView()
    }
}
