//
//  AppError.swift
//  Habit
//
//  Created by Rogério Júnior on 05/05/23.
//

import Foundation

enum AppError: Error {
  case response(message: String)
  
  public var message: String {
    switch self {
      case .response(let message):
        return message
    }
  }
}

