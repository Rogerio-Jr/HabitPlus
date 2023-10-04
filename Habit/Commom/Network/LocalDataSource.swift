//
//  LocalDataSource.swift
//  Habit
//
//  Created by Rogério Júnior on 10/05/23.
//

import Foundation
import Combine

class LocalDataSource {
    
    static var shared: LocalDataSource = LocalDataSource()
    
    private init() {
    }
    
    // salvar os dados locais
    private func saveValue(value: UserAuth) {
      UserDefaults.standard.set(try? PropertyListEncoder().encode(value), forKey: "user_key")
    }
    
    //ler os dados locais
    private func readValue(forKey key: String) -> UserAuth? {
      var userAuth: UserAuth?
      if let data = UserDefaults.standard.value(forKey: key) as? Data {
        userAuth = try? PropertyListDecoder().decode(UserAuth.self, from: data)
      }
      
      return userAuth
    }
}

//busca e grava as funcoes acimas

extension LocalDataSource {
  
  // incluir
  func insertUserAuth(userAuth: UserAuth) {
    saveValue(value: userAuth)
  }
  
 //buscar
  func getUserAuth() -> Future<UserAuth?, Never> {
    let userAuth = readValue(forKey: "user_key")
    return Future { promise in
      promise(.success(userAuth))
    }
  }
  
}


