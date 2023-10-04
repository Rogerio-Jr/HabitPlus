//
//  SingUpViewModel.swift
//  Habit
//
//  Created by Rogério Júnior on 19/02/23.
//

import SwiftUI
import Combine

class SignUpViewModel: ObservableObject {

@Published var fullName = ""
@Published var email = ""
@Published var password = ""
@Published var document = ""
@Published var phone = ""
@Published var birthday = ""
@Published var gender = Gender.male

var publisher: PassthroughSubject<Bool, Never>!

private var cancellableSignUp: AnyCancellable?
private var cancellableSignIn: AnyCancellable?

    @Published var uiState: SingUpUIState = .nome

private let interactor: SignUpInteractor

init(interactor: SignUpInteractor) {
  self.interactor = interactor
}

deinit {
  cancellableSignUp?.cancel()
  cancellableSignIn?.cancel()
}

func signUp() {
  self.uiState = .loading
  
  // Pegar a String -> dd/MM/yyyy -> Date
  let formatter = DateFormatter()
  formatter.locale = Locale(identifier: "en_US_POSIX")
  formatter.dateFormat = "dd/MM/yyyy"
  
  let dateFormatted = formatter.date(from: birthday)
  
  // Validar a Data
  guard let dateFormatted = dateFormatted else {
    self.uiState = .error("Data inválida \(birthday)")
    return
  }
  
  // Date -> yyyy-MM-dd -> String
  formatter.dateFormat = "yyyy-MM-dd"
  let birthday = formatter.string(from: dateFormatted)
  
  // Main Thread
  let signUpRequest = SingUpRequest(fullName: fullName,
                                    email: email,
                                    password: password,
                                    document: document,
                                    phone: phone,
                                    birthday: birthday,
                                    gender: gender.index)
  
  cancellableSignUp = interactor.postUser(signUpRequest: signUpRequest)
    .receive(on: DispatchQueue.main)
    .sink { completion in
      // error | finished
      switch(completion) {
        case .failure(let appError):
          self.uiState = .error(appError.message)
          break
        case .finished:
          break
      }
      
    } receiveValue: { created in
      if (created) {
        // se tiver criado -> Login
        
        self.cancellableSignIn = self.interactor.login(signInRequest: SingInRequest(email: self.email, password: self.password))
          .receive(on: DispatchQueue.main)
          .sink { completion in
            switch(completion) {
              case .failure(let appError):
                self.uiState = .error(appError.message)
                break
              case .finished:
                break
            }
          } receiveValue: { success in
            print(created)
            
            let auth = UserAuth(idToken: success.accessToken,
                                refreshToken: success.refreshToken,
                                expires: Date().timeIntervalSince1970 + Double(success.expires),
                                tokenType: success.tokenType)
            
            self.interactor.insertAuth(userAuth: auth)
            
            self.publisher.send(created)
              self.uiState = .sucess
          }
      }
    }
}

}

extension SignUpViewModel {
func homeView() -> some View {
  return SingUpViewRouter.makeHomeView()
}
}
