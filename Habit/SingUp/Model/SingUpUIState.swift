//
//  SingUpUIState.swift
//  Habit
//
//  Created by Rogério Júnior on 19/02/23.
//

import Foundation

enum SingUpUIState: Equatable {
    case nome
    case loading
    case sucess
    case error(String)
}
