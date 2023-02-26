//
//  Gender.swift
//  Habit
//
//  Created by Rogério Júnior on 18/02/23.
//

import Foundation

enum Gender: String, CaseIterable, Identifiable {
    
    case male = "Masculino"
    case famele = "Feminino"
    
    var id: String {
        self.rawValue
    }
    
}
