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
            switch viewModel.uistate {
            case .loading:
                    loadingView()
                
            case .goToSingInScreen:
                viewModel.singInView()
                
            case .goToHomeScreen:
                Text("Carregar tela principal")
                
            case .error(let msg):
                loadingView(error: msg)
            }
        }.onAppear (perform: viewModel.onAppear)
    }
}

// 3 - Funcao
extension SplashView{
    func loadingView(error: String? = nil) -> some View{
        ZStack{
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(20)
                .ignoresSafeArea()
            
            if let error = error {
                Text("")
                    .alert(isPresented: .constant(true)){
                        Alert(title: Text("Habit"), message: Text(error), dismissButton: .default(Text("Ok")){
                            
                        })
                     }
            }
        } 
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            let viewModel = SplashViewModel()
            SplashView(viewModel: viewModel)
                .previewDevice("Iphone 11")
                .preferredColorScheme($0)
        }
        
        
    }
}
