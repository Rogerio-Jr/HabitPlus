//
//  SplashRemoteDataSource.swift
//  Habit
//
//  Created by Rogério Júnior on 14/05/23.
//

//
//  SplashRemoteDataSource.swift
//  Habit
//
//  Created by Tiago Aguiar on 02/06/21.
//

import Foundation
import Combine


class SplashRemoteDataSource {
  
  static var shared: SplashRemoteDataSource = SplashRemoteDataSource()
  
  private init() {
  }
  
  func refreshToken(request: RefreshRequest) -> Future<SingInResponse, AppError> {
    return Future<SingInResponse, AppError> { promise in
        WebService.call(path: .refreshToken, method: .put, body: request) { result in
        switch result {
          case .failure(let error, let data):
            if let data = data {
              if error == .unauthorized {
                let decoder = JSONDecoder()
                let response = try? decoder.decode(SignErrorResponse.self, from: data)
                // completion(nil, response)
                
                promise(.failure(AppError.response(message: response?.detail.message ?? "Erro desconhecido no servidor")))
              }
            }
            break
          case .success(let data):
            let decoder = JSONDecoder()
            let response = try? decoder.decode(SingInResponse.self, from: data)
            // completion(response, nil)
            
            guard let response = response else {
              print("Log: Error parser \(String(data: data, encoding: .utf8)!)")
              return
            }
            
            promise(.success(response))
            
            break
        }
      }
    }
    
  }
  
}

