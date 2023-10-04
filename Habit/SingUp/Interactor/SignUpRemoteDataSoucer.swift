//
//  SignUpRemoteDataSoucer.swift
//  Habit
//
//  Created by Rogério Júnior on 09/05/23.
//

import Foundation
import Combine

class SignUpRemoteDataSource {
  
  // padrao singleton
  // Temos apenas 1 unico objeto vivo dentro da aplicação
  
  static var shared: SignUpRemoteDataSource = SignUpRemoteDataSource()
  
  private init() {
  }
     func postUser(request: SingUpRequest) -> Future<Bool, AppError> {
         return Future { promise in
             WebService.call(path: .postUser, method: .post, body: request) { result in
               switch result {
                 case .failure(let error, let data):
                   if let data = data {
                     if error == .badRequest {
                       let decoder = JSONDecoder()
                       let response = try? decoder.decode(ErroResponse.self, from: data)
                         promise(.failure(AppError.response(message: response?.detail ?? "Error interno no servidor")))
                         //completion(nil, response)
                     }
                   }
                   break
                 case .success(_):
                   promise(.success(true))
                   //completion(true, nil)
                   break
               }
             }
         }
    
    }
  
  }
  
