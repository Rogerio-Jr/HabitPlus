//
//  ChartRemoteDataSource.swift
//  Habit
//
//  Created by Rogério Júnior on 04/07/23.
//

import Foundation
import Combine

class ChartRemoteDataSource {
  
  static var shared: ChartRemoteDataSource = ChartRemoteDataSource()
  
  private init() {
  }
  
  func fetchHabitValues(habitId: Int) -> Future<[HabitValueResponse], AppError> {
    return Future { promise in
      let path = String(format: WebService.Endpoint.habitValues.rawValue, habitId)
      
      WebService.call(path: path, method: .get) { result in
        switch result {
          case .failure(_, let data):
            if let data = data {
              let decoder = JSONDecoder()
              let response = try? decoder.decode(ErroResponse.self, from: data)
              promise(.failure(AppError.response(message: response?.detail ?? "Erro interno no servidor")))
            }
            break
          case .success(let data):
            let decoder = JSONDecoder()
            let response = try? decoder.decode([HabitValueResponse].self, from: data)
            
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
