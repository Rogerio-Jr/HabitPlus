//
//  HabitUIState.swift
//  Habit
//
//  Created by Rogério Júnior on 19/05/23.
//

import Foundation


enum HabitUIState: Equatable {
    case loading
    case emptyList
    case fullList([HabitCardViewModel])
    case error(String)
}
