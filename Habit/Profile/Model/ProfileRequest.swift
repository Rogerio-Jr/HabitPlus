//
//  ProfileRequest.swift
//  Habit
//
//  Created by Rogério Júnior on 08/06/23.
//

import Foundation

struct ProfileRequest: Encodable {
  
  let fullName: String
  let phone: String
  let birthday: String
  let gender: Int
  
  enum CodingKeys: String, CodingKey {
    case fullName = "name"
    case phone
    case birthday
    case gender
  }
  
}
