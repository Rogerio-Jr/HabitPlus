//
//  SingUpViewRouter.swift
//  Habit
//
//  Created by Rogério Júnior on 19/02/23.
//

import SwiftUI


enum SingUpViewRouter {
    static func makeHomeView() -> some View {
        let viewModel = HomeViewModel()
        return HomeView (viewModel: viewModel)
    }
}
