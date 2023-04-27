//
//  SingUpViewModel.swift
//  Habit
//
//  Created by Rogério Júnior on 19/02/23.
//

import SwiftUI
import Combine

class SingUpViewModel: ObservableObject {
    
    @Published var fullName = ""
    @Published var email = ""
    @Published var password = ""
    @Published var document = ""
    @Published var phone = ""
    @Published var birthday = ""
    @Published var gender = Gender.male
    
    var publisher: PassthroughSubject<Bool, Never>!
    
    @Published var uiState: SingUpUIState = .nome
    
    func singUp(){
        self.uiState = .loading
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "dd/MM/yyyy"
        
        let dateFomatted = formatter.date(from: birthday)
        
        guard let dateFomatted = dateFomatted else {
            self.uiState = .error("Data inválida \(birthday)")
            return
        }
        
        formatter.dateFormat = "yyyy-MM-dd"
        let birthday = formatter.string(from: dateFomatted)
        
        WebService.postUser(request: SingUpRequest(fullName: fullName,
                                                   email: email,
                                                   password: password,
                                                   document: document,
                                                   phone: phone,
                                                   birthday: birthday,
                                                   gender: gender.index)){ (sucessResponse, errorResponse) in
            if let error = errorResponse {
                DispatchQueue.main.async {
                    self.uiState = .error(error.detail)
                }
            }
            
            if let sucess = sucessResponse {
                
                WebService.login(request: SingInRequest(email: self.email,
                                                        password: self.password)) { (successResponse, errorResponse) in
                    
                    if let errorSignIn = errorResponse {
                        DispatchQueue.main.async {
                            // Main Thread
                            self.uiState = .error(errorSignIn.detail.message)
                        }
                    }
                    
                    if let successSignIn = successResponse {
                        DispatchQueue.main.async {
                            print(successSignIn)
                            self.publisher.send(sucess)
                                self.uiState = .sucess
                           
                        }
                    }
                    
                }
                
                DispatchQueue.main.async {
                    
                }
            }
        }
    }
}

extension SingUpViewModel {
    func homeView()-> some View{
        return SingUpViewRouter.makeHomeView()
    }
}
