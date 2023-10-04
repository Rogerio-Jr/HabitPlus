//
//  SingInViewRouter.swift
//  Habit
//
//  Created by Rogério Júnior on 06/02/23.
//

import SwiftUI
import Combine

enum SingInViewRouter {
    static func makeHomeView() -> some View {
        let viewModel = HomeViewModel()
        return HomeView (viewModel: viewModel)
    }
    static func makeSingUpView(publisher: PassthroughSubject<Bool, Never>) -> some View{
        let viewModel = SignUpViewModel(interactor: SignUpInteractor())
        viewModel.publisher = publisher
        return SingUpView(viewModel: viewModel)
    }
}
