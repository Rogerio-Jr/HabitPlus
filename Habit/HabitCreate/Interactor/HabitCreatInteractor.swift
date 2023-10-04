//
//  HabitCreatInteractor.swift
//  Habit
//
//  Created by Rogério Júnior on 07/07/23.
//

import Foundation
import Combine

class HabitCreateInteractor {
  
  private let remote: HabitCreateRemoteDataSource = .shared
  
}

extension HabitCreateInteractor {
  
  func save(habitCreateRequest request: HabitCreateRequest) -> Future<Void, AppError> {
    return remote.save(request: request)
  }
}
