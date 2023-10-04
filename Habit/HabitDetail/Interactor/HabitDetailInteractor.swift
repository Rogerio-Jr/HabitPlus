//
//  HabitDetailInteractor.swift
//  Habit
//
//  Created by Rogério Júnior on 28/05/23.
//

import Foundation
import Combine

class HabitDetailInteractor {
  
  private let remote: HabitDetailRemoteDataSource = .shared
  
}

extension HabitDetailInteractor {
  
    func save(habitId: Int, habitValuerequest request: HabitValueRequest) -> Future<Bool, AppError> {
    return remote.save(habitId: habitId, request: request)
  }
}
