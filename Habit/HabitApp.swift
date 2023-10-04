//
//  HabitApp.swift
//  Habit
//
//  Created by Rogério Júnior on 31/01/23.
//

import SwiftUI

@main
struct HabitApp: App {
    var body: some Scene {
        WindowGroup {
            SplashView(viewModel: SplashViewModel(interactor: SplashInteractor()))
        }
    }
}
