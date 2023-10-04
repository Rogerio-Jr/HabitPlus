//
//  HabitRemoteDataSouce.swift
//  Habit
//
//  Created by Rogério Júnior on 23/05/23.
//

import Foundation
import Combine


class HabitInRemoteDataSource {
  
  static var shared: HabitInRemoteDataSource = HabitInRemoteDataSource()
  
  private init() {
  }
  
  func fetchHabits()-> Future<[HabitResponse], AppError> {
    return Future<[HabitResponse], AppError> { promise in
        WebService.call(path: .habits, method: .get) { result in
        switch result {
          case .failure(_, let data):
            if let data = data {
              
                let decoder = JSONDecoder()
                let response = try? decoder.decode(SignErrorResponse.self, from: data)
                // completion(nil, response)
                
                promise(.failure(AppError.response(message: response?.detail.message ?? "Erro desconhecido no servidor")))
            }
            break
          case .success(let data):
            let decoder = JSONDecoder()
            let response = try? decoder.decode([HabitResponse].self, from: data)
            // completion(response, nil)
            
            guard let res = response else {
              print("Log: Error parser \(String(data: data, encoding: .utf8)!)")
              return
            }
            
            promise(.success(res))
            
            break
        }
      }
    }
    
  }
  
}
