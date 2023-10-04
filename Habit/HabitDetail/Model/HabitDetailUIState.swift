//
//  HabitDetailUIState.swift
//  Habit
//
//  Created by Rogério Júnior on 28/05/23.
//

import Foundation

enum HabitDetailUIState: Equatable {
    case none
    case loading
    case sucess
    case error(String)
}
