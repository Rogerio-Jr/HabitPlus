//
//  ErroResponse.swift
//  Habit
//
//  Created by Rogério Júnior on 23/03/23.
//

import Foundation

struct ErroResponse: Decodable {
    
    let detail: String
    
    
    enum CodingKeys: String, CodingKey {
        case detail
        
    }

    
}
