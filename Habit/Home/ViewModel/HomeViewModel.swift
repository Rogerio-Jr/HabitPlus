//
//  HomeViewModel.swift
//  Habit
//
//  Created by Rogério Júnior on 06/02/23.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    let habitViewModel = HabitViewModel(isCharts: false, interactor: HabitInteractor())
    let habitForChartsViewModel = HabitViewModel(isCharts: true, interactor: HabitInteractor())
    let profileViewModel = ProfileViewModel(interactor: ProfileInteractor())
}

extension HomeViewModel {
    func habitView() -> some View {
        return HomeViewRouter.makeHabitView(viewModel: habitViewModel)
    }
    func habitForChartView() -> some View {
      return HomeViewRouter.makeHabitView(viewModel: habitForChartsViewModel)
    }
    func profileView() -> some View {
        return HomeViewRouter.makeProfileView(viewModel: profileViewModel)
    }
}
