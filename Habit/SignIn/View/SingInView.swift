//
//  SingInView.swift
//  Habit
//
//  Created by Rogério Júnior on 01/02/23.
//

import SwiftUI

struct SingInView: View {
    
    @ObservedObject var viewModel: SingInViewModel
    
    @State var email = ""
    @State var password = ""
    
    @State var action: Int? = 0
    
    @State var navigationHidden = true
     
    var body: some View {
        
        ZStack {
            if case SingInUiState.goToHomeScreen = viewModel.uiState{
                viewModel.homeView()
            }else {
                NavigationView {
                    
                    ScrollView(showsIndicators: false) {
                        
                        VStack(alignment: .center, spacing: 20) {
                            
                            Spacer(minLength: 40)
                            
                            VStack(alignment: .center, spacing: 8) {
                                Image("logo")
                                    .resizable()
                                    .scaledToFit()
                                    .padding(.horizontal, 48)
                                
                                Text("Login")
                                    .foregroundColor(Color.orange)
                                    .font(Font.system(.title).bold())
                                    .padding(.bottom, 8)
                                
                                emailField
                                
                                passWordField
                                
                                enterButton
                                
                                registerLink
                                
                                Text("Copyrigth Rogerio Jr - 2022")
                                    .foregroundColor(Color.gray)
                                    .font(Font.system(size: 13).bold())
                                    .padding(.top, 16)
                            }
                        }
                        
                        if case SingInUiState.error(let value) = viewModel.uiState{
                            Text("")
                                .alert(isPresented: .constant(true)){
                                    Alert(title: Text("Habit"), message: Text(value), dismissButton: .default(Text("Ok")){
                                        
                                    })
                                 }
                        }
                        
                    }.frame(maxWidth: .infinity, maxHeight: .infinity)
                        .padding(.horizontal, 32)
                        .navigationBarTitle("Login", displayMode: .inline)
                        .navigationBarHidden(navigationHidden)
                }            }
        }
        
       
    }
}

extension SingInView {
    var emailField: some View {
        EditTextView(text: $email,
                     placeholder: "E-mail",
                     keyboard: .emailAddress,
                     error: "E-mail inválido",
                     failure: !email.isEmail())
        
    }}

extension SingInView {
    var passWordField: some View {
    EditTextView(text: $password,
                 placeholder: "Senha",
                 keyboard: .emailAddress,
                 error: "Senha deve ter ao menos 8 caracteres",
                 failure: password.count < 8,
                 isSecure: true)
    }}

extension SingInView {
  var enterButton: some View {
    
      LoadingButtonView(action: {
          viewModel.login(email: email, password: password)
      }, disable: !email.isEmail() || password.count < 8,
                        showProgress: self.viewModel.uiState == SingInUiState.loading,
                        text: "Entrar")
  }
}

extension SingInView {
    var registerLink: some View {
        VStack {
            Text("Ainda não possui um login ativo?")
                .foregroundColor(Color.gray)
                .padding(.top, 48)
                        
            ZStack {
                NavigationLink(destination:
                                viewModel.singUpView(),
                               tag: 1,
                               selection: $action,
                               label: {EmptyView()})
                
                Button("Realize seu cadastro") {
                    self.action = 1
                }
                
            }
            
        }
    }
}

struct SingIn_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            let viewModel = SingInViewModel()
            SingInView(viewModel: viewModel)
                .previewDevice("Iphone 11")
                .preferredColorScheme($0)
        }
    }
}
