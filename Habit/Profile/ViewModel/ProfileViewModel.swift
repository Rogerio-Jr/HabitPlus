//
//  ProfileViewModel.swift
//  Habit
//
//  Created by Rogério Júnior on 05/06/23.
//

import Foundation
import Combine

class ProfileViewModel: ObservableObject {
  
  @Published var uiState: ProfileUIState = .none
  
  @Published var fullNameValidation = FullNameValidation()
  @Published var phoneValidation = PhoneValidation()
  @Published var birthdayValidation = BirthdayValidation()
  
  var userId: Int?
  @Published var email = ""
  @Published var document = ""
  @Published var gender: Gender?
  
  private var cancellableFetch: AnyCancellable?
  private var cancellableUpdate: AnyCancellable?
  
  private let interactor: ProfileInteractor
  
  init(interactor: ProfileInteractor) {
    self.interactor = interactor
  }
  
  deinit {
    cancellableFetch?.cancel()
    cancellableUpdate?.cancel()
  }
  
  func fetchUser() {
    self.uiState = .loading
    
    cancellableFetch = interactor.fetchUser()
      .receive(on: DispatchQueue.main)
      .sink(receiveCompletion: { completion in
        switch(completion) {
          case .failure(let appError):
            self.uiState = .fetchError(appError.message)
            break
          case .finished:
            break
        }
      }, receiveValue: { response in
        self.userId = response.id
        self.email = response.email
        self.document = response.document
        self.gender = Gender.allCases[response.gender]
        self.fullNameValidation.value = response.fullName
        self.phoneValidation.value = response.phone
        
        // Pegar a String -> dd/MM/yyyy -> Date
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd"
        
        let dateFormatted = formatter.date(from: response.birthday)
        
        // Validar a Data
        guard let dateFormatted = dateFormatted else {
          self.uiState = .fetchError("Data inválida \(response.birthday)")
          return
        }
        
        // Date -> yyyy-MM-dd -> String
        formatter.dateFormat = "dd/MM/yyyy"
        let birthday = formatter.string(from: dateFormatted)
        
        
        self.birthdayValidation.value = birthday
        
        self.uiState = .fetchSuccess
      })
  }
  
  func updateUser() {
    self.uiState = .updateLoading
    
    guard let userId = userId,
          let gender = gender else { return }
    
    // Pegar a String -> dd/MM/yyyy -> Date
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "en_US_POSIX")
    formatter.dateFormat = "dd/MM/yyyy"
    
    let dateFormatted = formatter.date(from: birthdayValidation.value)
    
    // Validar a Data
    guard let dateFormatted = dateFormatted else {
      self.uiState = .updateError("Data inválida \(birthdayValidation.value)")
      return
    }
    
    // Date -> yyyy-MM-dd -> String
    formatter.dateFormat = "yyyy-MM-dd"
    let birthday = formatter.string(from: dateFormatted)
    
    cancellableUpdate = interactor.updateUser(userId: userId,
                                              profileRequest: ProfileRequest(fullName: fullNameValidation.value,
                                                                             phone: phoneValidation.value,
                                                                             birthday: birthday,
                                                                             gender: gender.index))
      .receive(on: DispatchQueue.main)
      .sink(receiveCompletion: { completion in
        switch(completion) {
          case .failure(let appError):
            self.uiState = .updateError(appError.message)
            break
          case .finished:
            break
        }
      }, receiveValue: { response in
        self.uiState = .updateSuccess
      })
  }
  
}

class FullNameValidation: ObservableObject {
  
  @Published var failure = false
  
  var value: String = "Teste" {
    didSet {
      failure = value.count < 3
    }
  }
  
}

class PhoneValidation: ObservableObject {
  
  @Published var failure = false
  
  var value: String = "11912341234" {
    didSet {
      failure = value.count < 10 || value.count >= 12
    }
  }
  
}

class BirthdayValidation: ObservableObject {
  
  @Published var failure = false
  
  var value: String = "20/02/1990" {
    didSet {
      failure = value.count != 10
    }
  }
  
}
