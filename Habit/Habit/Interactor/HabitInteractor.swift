//
//  HabitInteractor.swift
//  Habit
//
//  Created by Rogério Júnior on 23/05/23.
//

import Foundation
import Combine

class HabitInteractor {
  
    private let remote: HabitInRemoteDataSource = .shared
  
}

extension HabitInteractor {
  
  func fetchHabits() -> Future<[HabitResponse], AppError> {
      return remote.fetchHabits()
  }
}
