//
//  ProfileInteractor.swift
//  Habit
//
//  Created by Rogério Júnior on 05/06/23.
//

import Foundation
import Combine

class ProfileInteractor {
  
  private let remote: ProfileRemoteDataSource = .shared
  
}

extension ProfileInteractor {
  
  func fetchUser() -> Future<ProfileResponse, AppError> {
    return remote.fetchUser()
  }
    func updateUser(userId: Int, profileRequest: ProfileRequest) -> Future<ProfileResponse, AppError> {
      return remote.updateUser(userId: userId, request: profileRequest)
    }
}
