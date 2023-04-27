//
//  SingInErrorResponse.swift
//  Habit
//
//  Created by Rogério Júnior on 23/04/23.
//

import Foundation

struct SignErrorResponse: Decodable {
    
    let detail: SignErrorDetailResponse
    
    enum CodingKeys: String, CodingKey {
        case detail
        
    }
}

struct SignErrorDetailResponse: Decodable {
    
    let message: String
    
    enum CodingKeys: String, CodingKey {
        case message
        
    }
}

