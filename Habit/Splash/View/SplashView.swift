//
//  SplashView.swift
//  Habit
//
//  Created by Rogério Júnior on 31/01/23.
//
import SwiftUI

struct SplashView: View {
  
  @ObservedObject var viewModel: SplashViewModel

  var body: some View {
    Group {
      switch viewModel.uiState {
        case .loading:
          loadingView()
        case .goToSingInScreen:
          // navegar para proxima tela
          viewModel.signInView()
          
        case .goToHomeScreen:
          viewModel.homeView()
        // navegar para proxima tela
        case .error(let msg):
          loadingView(error: msg)
      }
    }.onAppear(perform: viewModel.onAppear)
  }
  
}

extension SplashView {
  func loadingView(error: String? = nil) -> some View {
    ZStack {
      Image("logo")
        .resizable()
        .scaledToFit()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(20)
        .ignoresSafeArea()
      
      if let error = error {
        Text("")
          .alert(isPresented: .constant(true)) {
            Alert(title: Text("Habit"), message: Text(error), dismissButton: .default(Text("Ok")) {
              // faz algo quando some o alerta
            })
          }
       }
    }
  }
}

struct SplashView_Previews: PreviewProvider {
  static var previews: some View {
    ForEach(ColorScheme.allCases, id: \.self) {
      let viewModel = SplashViewModel(interactor: SplashInteractor())
      SplashView(viewModel: viewModel)
        .previewDevice("iPhone 11")
        .preferredColorScheme($0)
    }
  }
}
