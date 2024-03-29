//
//  SingInUIState.swift
//  Habit
//
//  Created by Rogério Júnior on 04/02/23.
//

import Foundation

enum SingInUiState: Equatable {
    case none
    case loading
    case goToHomeScreen
    case error(String)
}
