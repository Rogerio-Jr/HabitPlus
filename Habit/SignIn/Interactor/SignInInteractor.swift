//
//  SignInInteractor.swift
//  Habit
//
//  Created by Rogério Júnior on 04/05/23.
//

import Foundation
import Combine

class SignInInteractor {
  
  private let remote: SignInRemoteDataSource = .shared
  // private let local: LocalDataSource
  
}

extension SignInInteractor {
  
  func login(loginRequest request: SingInRequest) -> Future<SingInResponse, AppError> {
    return remote.login(request: request)
  }
  
}
