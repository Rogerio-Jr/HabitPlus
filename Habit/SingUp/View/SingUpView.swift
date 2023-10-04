//
//  SingUpView.swift
//  Habit
//
//  Created by Rogério Júnior on 15/02/23.
//

import SwiftUI

struct SingUpView: View {
    
    @ObservedObject var viewModel: SignUpViewModel
    
    //TODO: gender
    
    var body: some View {
        ZStack{
            ScrollView(showsIndicators: false) {
                VStack(alignment: .center){
                    
                    VStack(alignment: .leading, spacing: 8) {
                        
                        Text("Cadastro")
                            .foregroundColor(Color("textColor"))
                            .font(Font.system(.title).bold())
                            .padding(.bottom, 8)
                        
                        fullNameField
                        
                        emailField
                        
                        passWordFied
                        
                        documentField
                        
                        phoneField
                        
                        birthdayField
                        
                        genderField
                        
                        saveButton
                    }
                    Spacer()
                }.padding(.horizontal, 8)
            }.padding()
            if case SingUpUIState.error(let value) =
                viewModel.uiState{
                
                Text("")
                    .alert(isPresented: .constant(true)){
                        Alert(title: Text("Habit"), message: Text(value), dismissButton: .default(Text("Ok")){
                            
                        })
                    }
                
            }
        }
        
    }
}

extension SingUpView {
    var fullNameField: some View {
        EditTextView(text: $viewModel.fullName,
                     placeholder: "Entre com o nome completo *",
                     keyboard: .alphabet,
                     error: "Nome inválido",
                     failure: viewModel.fullName.count < 3,
                     autocapitalization: .words)
    }
}

extension SingUpView {
    var emailField: some View {
        EditTextView(text: $viewModel.email,
                     placeholder: "Entre com o e-mail completo *",
                     keyboard: .emailAddress,
                     error: "E-mail inválido",
                     failure: !viewModel.email.isEmail())}}

extension SingUpView {
    var passWordFied: some View {
        EditTextView(text: $viewModel.password,
                     placeholder: "Entre com a sua senha *",
                     keyboard: .emailAddress,
                     error: "Senha deve ter ao menos 8 caracteres",
                     failure: viewModel.password.count < 8,
                     isSecure: true)
    }}

extension SingUpView {
    var documentField: some View {
        EditTextView(text: $viewModel.document,
                     placeholder: "Entre com o seu CPF *",
                     keyboard: .numberPad,
                     error: "CPF inválido",
                     failure: viewModel.document.count != 11 )
        //TODO: mask
        //TODO: isDisabled
    }}

extension SingUpView {
    var phoneField: some View {
        EditTextView(text: $viewModel.phone,
                     placeholder: "Entre com o seu celular *",
                     keyboard: .numberPad,
                     error: "Entre com o DDD +8 ou 9 digitos",
                     failure: viewModel.phone.count < 10 || viewModel.phone.count >= 12 )
        //TODO: mask
        
    }}

extension SingUpView {
    var birthdayField: some View {
        EditTextView(text: $viewModel.birthday,
                     placeholder: "Entre com a data do seu nascimento *",
                     keyboard: .numberPad,
                     error: "Data deve ser dd/MM/yyyy",
                     failure: viewModel.birthday.count != 10 )
        //TODO: mask
        
    }}

extension SingUpView {
    var genderField: some View {
        Picker("Gender", selection: $viewModel.gender){
            ForEach(Gender.allCases, id: \.self) { value in
                Text(value.rawValue)
                    .tag(value)
            }
            
        }.pickerStyle(SegmentedPickerStyle())
            .padding(.top, 16)
            .padding(.bottom, 32)
    }
}

extension SingUpView {
    var saveButton: some View {
        LoadingButtonView(action: {
            viewModel.signUp()
        }, disable: !viewModel.email.isEmail() ||
                          viewModel.password.count < 8 ||
                          viewModel.fullName.count < 3 ||
                          viewModel.document.count != 11 ||
                          viewModel.phone.count < 10 || viewModel.phone.count >= 12 ||
                          viewModel.birthday.count != 10,
                          
                          showProgress: self.viewModel.uiState == SingUpUIState.loading,
                          text: "Realize seu cadastro")
        }
    }

struct SingUpView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            SingUpView(viewModel: SignUpViewModel(interactor: SignUpInteractor()))
                .previewDevice("Iphone 11")
                .preferredColorScheme($0)
        }
    }
}

