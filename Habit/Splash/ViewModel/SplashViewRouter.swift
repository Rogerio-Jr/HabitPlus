//
//  SplashViewRouter.swift
//  Habit
//
//  Created by Rogério Júnior on 01/02/23.
//

import SwiftUI

enum SplashViewRouter {
    
    static func makeSingInView() -> some View {
        let viewModel = SignInViewModel(interactor: SignInInteractor())
        return SingInView (viewModel: viewModel)
        
    }
    
}
