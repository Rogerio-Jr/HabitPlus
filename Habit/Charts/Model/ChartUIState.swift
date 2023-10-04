//
//  ChartUIState.swift
//  Habit
//
//  Created by Rogério Júnior on 04/07/23.
//

import Foundation

enum ChartUIState: Equatable {
  case loading
  case emptyChart
  case fullChart
  case error(String)
}
