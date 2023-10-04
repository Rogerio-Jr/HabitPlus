//
//  ChartInteractor.swift
//  Habit
//
//  Created by Rogério Júnior on 04/07/23.
//

import Foundation
import Combine

class ChartInteractor {
  
  private let remote: ChartRemoteDataSource = .shared
  
}

extension ChartInteractor {
  
  func fetchHabitValues(habitId: Int) -> Future<[HabitValueResponse], AppError> {
    return remote.fetchHabitValues(habitId: habitId)
  }
  
}

