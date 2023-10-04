//
//  ProfileRemoteDataSource.swift
//  Habit
//
//  Created by Rogério Júnior on 05/06/23.
//

import Foundation
import Combine

class ProfileRemoteDataSource {
  
  static var shared: ProfileRemoteDataSource = ProfileRemoteDataSource()
  
  private init() {
  }
  
  func fetchUser() -> Future<ProfileResponse, AppError> {
    return Future { promise in
      WebService.call(path: .fetchUser, method: .get) { result in
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
            let response = try? decoder.decode(ProfileResponse.self, from: data)
            
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
    
    func updateUser(userId: Int, request profileRequest: ProfileRequest) -> Future<ProfileResponse, AppError> {
      return Future { promise in
        let path = String(format: WebService.Endpoint.updateUser.rawValue, userId)
        WebService.call(path: path, method: .put, body: profileRequest) { result in
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
              let response = try? decoder.decode(ProfileResponse.self, from: data)
              
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
