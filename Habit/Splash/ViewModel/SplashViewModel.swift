//
//  SplashViewModel.swift
//  Habit
//
//  Created by Rogério Júnior on 31/01/23.
//

import SwiftUI


class SplashViewModel: ObservableObject {
    
    @Published var uistate: SplashUIState = .loading
    
    func onAppear(){
        
        DispatchQueue.main.asyncAfter(deadline: .now()+3){
            self.uistate = .goToSingInScreen
        }
    }
    
    func singInView() -> some View {
        return SplashViewRouter.makeSingInView()
    }

}
