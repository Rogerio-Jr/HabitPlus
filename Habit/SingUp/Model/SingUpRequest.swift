//
//  SingUpRequest.swift
//  Habit
//
//  Created by Rogério Júnior on 04/03/23.
//

import Foundation

struct SingUpRequest: Encodable { //codificar para transforma objeto em json

    let fullName: String
    let email: String
    let password: String
    let document: String
    let phone: String
    let birthday: String
    let gender: Int
    
    enum CodingKeys: String, CodingKey {
        case fullName = "name"
        case email
        case password
        case document
        case phone
        case birthday
        case gender
    }
}
