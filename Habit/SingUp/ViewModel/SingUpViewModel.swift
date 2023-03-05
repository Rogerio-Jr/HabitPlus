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
        
        WebService.postUser(fullName: fullName,
                            email: email,
                            password: password,
                            document: document,
                            phone: phone,
                            birthday: birthday,
                            gender: gender.index)
        
//        DispatchQueue.main.asyncAfter(deadline: .now()+1){
//           // self.uiState = .error("Usuario já existente!")
//            self.uiState = .sucess
//            self.publisher.send(true)
//        }
    }
}

extension SingUpViewModel {
    func homeView()-> some View{
        return SingUpViewRouter.makeHomeView()
    }
}
