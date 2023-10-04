//
//  SingInViewModel.swift
//  Habit
//
//  Created by Rogério Júnior on 01/02/23.
import SwiftUI
import Combine

class SignInViewModel: ObservableObject {
  
  @Published var email = ""
  @Published var password = ""
  
  private var cancellable: AnyCancellable?
  private var cancellableRequest: AnyCancellable?
  private let publisher = PassthroughSubject<Bool, Never>()
  private let interactor: SignInInteractor
  
  @Published var uiState: SingInUiState = .none
  
  init(interactor: SignInInteractor) {
    self.interactor = interactor
    
    cancellable = publisher.sink { value in
      print("usuário criado! goToHome: \(value)")
      
      if value {
        self.uiState = .goToHomeScreen
      }
    }
  }
  
  deinit {
    cancellable?.cancel()
    cancellableRequest?.cancel()
  }

  func login() {
    self.uiState = .loading
    
    cancellableRequest = interactor.login(loginRequest: SingInRequest(email: email,
                                                                      password: password))
      .receive(on: DispatchQueue.main)
      .sink { completion in
        // aqui acontece o ERRO ou FINISHED
        switch(completion) {
          case .failure(let appError):
            self.uiState = SingInUiState.error(appError.message)
            break
          case .finished:
            break
        }
        
      } receiveValue: { success in
        // aqui acontece o SUCESSO
          let auth = UserAuth(idToken: success.accessToken,
                              refreshToken: success.refreshToken,
                              expires: Date().timeIntervalSince1970 + Double(success.expires),
                              tokenType: success.tokenType)
          
          self.interactor.insertAuth(userAuth: auth)
          self.uiState = .goToHomeScreen
      }
    }

    
//    interactor.login(loginRequest: SignInRequest(email: email,
//                                                 password: password)) { (successResponse, errorResponse) in
//
//      if let error = errorResponse {
//        DispatchQueue.main.async {
//          // Main Thread
//          self.uiState = .error(error.detail.message)
//        }
//      }
//
//      if let success = successResponse {
//        DispatchQueue.main.async {
//          print(success)
//          self.uiState = .goToHomeScreen
//        }
//      }
//
//    }
//  }
  
}

extension SignInViewModel {
  func homeView() -> some View {
    return SingInViewRouter.makeHomeView()
  }
  func signUpView() -> some View {
    return SingInViewRouter.makeSingUpView(publisher: publisher)
  }
}
