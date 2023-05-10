//
//  SignUpInteractor.swift
//  Habit
//
//  Created by Rogério Júnior on 09/05/23.
//

import Foundation
import Combine

class SignUpInteractor {
  
  private let remoteSignUp: SignUpRemoteDataSource = .shared
  private let remoteSignIn: SignInRemoteDataSource = .shared
  // private let local: LocalDataSource
  
}

extension SignUpInteractor {
  
  func postUser(signUpRequest request: SingUpRequest) -> Future<Bool, AppError> {
    return remoteSignUp.postUser(request: request)
  }
    
    func login(signInRequest request: SingInRequest) -> Future<SingInResponse, AppError> {
      return remoteSignIn.login(request: request)
    }
  
}
