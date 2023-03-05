//
//  SingInViewModel.swift
//  Habit
//
//  Created by Rogério Júnior on 01/02/23.
//

import SwiftUI
import Combine

class SingInViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    
    private var cancellable: AnyCancellable?
    
    private let publisher = PassthroughSubject<Bool, Never>()
    
    @Published var uiState: SingInUiState = .nome
    
    init(){
        cancellable = publisher.sink{ value in
            print("usuario criado! goToHome: \(value)")
            
            if value {
                self.uiState = .goToHomeScreen
            }
        }
    }
    
    deinit {
        cancellable?.cancel()
    }
    
    func login(){
        self.uiState = .loading
        DispatchQueue.main.asyncAfter(deadline: .now()+1){
            self.uiState = .goToHomeScreen
        }
    }
}

extension SingInViewModel {
    func homeView() -> some View {
        return SingInViewRouter.makeHomeView()
    }
    func singUpView() -> some View {
        return SingInViewRouter.makeSingUpView(publisher: publisher)
    }
}

