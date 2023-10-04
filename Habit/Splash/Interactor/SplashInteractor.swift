//
//  SplashInteractor.swift
//  Habit
//
//  Created by Rogério Júnior on 10/05/23.
//


import Foundation
import Combine

class SplashInteractor {
  
    private let remote: SplashRemoteDataSource = .shared
    private let local: LocalDataSource = .shared
  
}

extension SplashInteractor {
  
  func fetchAuth() -> Future<UserAuth?, Never> {
    return local.getUserAuth()
  }
 
    func insertAuth(userAuth: UserAuth) {
      local.insertUserAuth(userAuth: userAuth)
    }
    
    func refreshToken(refreshRequest request: RefreshRequest) -> Future<SingInResponse, AppError> {
        return remote.refreshToken(request: request)
    }

    
    
}
