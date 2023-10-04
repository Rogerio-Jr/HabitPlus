//
//  HabitViewRouter.swift
//  Habit
//
//  Created by Rogério Júnior on 06/07/23.
//

import Foundation
import Combine
import SwiftUI

enum HabitViewRouter {
  
  static func makeHabitCreateView(habitPublisher: PassthroughSubject<Bool, Never>) -> some View {
    let viewModel = HabitCreateViewModel(interactor: HabitCreateInteractor())
    viewModel.habitPublisher = habitPublisher
    return HabitCreateView(viewModel: viewModel)
  }
}
