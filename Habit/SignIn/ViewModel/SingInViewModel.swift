//
//  SingInViewModel.swift
//  Habit
//
//  Created by Rogério Júnior on 01/02/23.
//
import SwiftUI
import Combine

class SignInViewModel: ObservableObject {
  
  @Published var email = ""
  @Published var password = ""
  
  private var cancellable: AnyCancellable?
  
  private let publisher = PassthroughSubject<Bool, Never>()
  
  @Published var uiState: SingInUiState = .none
  
  init() {
    cancellable = publisher.sink { value in
      print("usuário criado! goToHome: \(value)")
      
      if value {
        self.uiState = .goToHomeScreen
      }
    }
  }
  
  deinit {
    cancellable?.cancel()
  }
  
  func login() {
    self.uiState = .loading
    
    WebService.login(request: SingInRequest(email: email,
                                            password: password)) { (successResponse, errorResponse) in
      
      if let error = errorResponse {
        DispatchQueue.main.async {
          // Main Thread
            self.uiState = .error(error.detail.message)
        }
      }
      
      if let success = successResponse {
        DispatchQueue.main.async {
          print(success)
          self.uiState = .goToHomeScreen
        }
      }
      
    }
  }
  
}

extension SignInViewModel {
  func homeView() -> some View {
    return SingInViewRouter.makeHomeView()
  }
  func signUpView() -> some View {
    return SingInViewRouter.makeSingUpView(publisher: publisher)
  }
}
