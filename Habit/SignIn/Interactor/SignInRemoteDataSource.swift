//
//  RemoteDataSource.swift
//  Habit
//
//  Created by Rogério Júnior on 04/05/23.
//
import Foundation
import Combine


class SignInRemoteDataSource {
  
  // padrao singleton
  // Temos apenas 1 unico objeto vivo dentro da aplicação
  
  static var shared: SignInRemoteDataSource = SignInRemoteDataSource()
  
  private init() {
  }
  
  func login(request: SingInRequest) -> Future<SingInResponse, AppError> {
    return Future<SingInResponse, AppError> { promise in
      WebService.call(path: .login, params: [
        URLQueryItem(name: "username", value: request.email),
        URLQueryItem(name: "password", value: request.password)
      ]) { result in
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
