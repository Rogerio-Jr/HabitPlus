//
//  RefreshRequest.swift
//  Habit
//
//  Created by Rogério Júnior on 14/05/23.
//

import Foundation

struct RefreshRequest: Encodable {
  
  let token: String
  
  enum CodingKeys: String, CodingKey {
    case token = "refresh_token"
  }
  
}
