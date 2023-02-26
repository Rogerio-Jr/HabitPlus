//
//  SingUpViewModel.swift
//  Habit
//
//  Created by Rogério Júnior on 19/02/23.
//

import SwiftUI
import Combine

class SingUpViewModel: ObservableObject {
    
    var publisher: PassthroughSubject<Bool, Never>!
    
    @Published var uiState: SingUpUIState = .nome
    
    func singUp(){
        self.uiState = .loading
        
        DispatchQueue.main.asyncAfter(deadline: .now()+1){
           // self.uiState = .error("Usuario já existente!")
            self.uiState = .sucess
            self.publisher.send(true)
        }
    }
}

extension SingUpViewModel {
    func homeView()-> some View{
        return SingUpViewRouter.makeHomeView()
    }
}
