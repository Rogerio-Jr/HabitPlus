//
//  SingInResponse.swift
//  Habit
//
//  Created by Rogério Júnior on 21/04/23.
//

import Foundation

struct SingInResponse: Decodable {
   
    let accessToken: String
    let refreshToken: String
    let expires: Int
    let tokenType: String
    
    enum CodingKeys: String, CodingKey {
      case accessToken = "access_token"
      case refreshToken = "refresh_token"
      case expires
      case tokenType = "token_type"
    }
}
