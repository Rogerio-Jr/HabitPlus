//
//  ProfileUIState.swift
//  Habit
//
//  Created by Rogério Júnior on 05/06/23.
//

import Foundation

enum ProfileUIState: Equatable {
    case none
    case loading
    case fetchSuccess
    case fetchError(String)

    case updateLoading
    case updateSuccess
    case updateError(String)
    
}
