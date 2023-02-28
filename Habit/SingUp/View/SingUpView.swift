//
//  SingUpView.swift
//  Habit
//
//  Created by Rogério Júnior on 15/02/23.
//

import SwiftUI

struct SingUpView: View {
    
    @State var fullName = ""
    @State var email = ""
    @State var password = ""
    @State var document = ""
    @State var phone = ""
    @State var birthday = ""
    @State var gender = Gender.male
    
    @ObservedObject var viewModel: SingUpViewModel
    
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
        EditTextView(text: $fullName,
                     placeholder: "Entre com o nome completo *",
                     keyboard: .alphabet,
                     error: "Nome inválido",
                     failure: fullName.count < 3)
    }
}

extension SingUpView {
    var emailField: some View {
        EditTextView(text: $email,
                     placeholder: "Entre com o e-mail completo *",
                     keyboard: .emailAddress,
                     error: "E-mail inválido",
                     failure: !email.isEmail())}}

extension SingUpView {
    var passWordFied: some View {
        EditTextView(text: $password,
                     placeholder: "Entre com a sua senha *",
                     keyboard: .emailAddress,
                     error: "Senha deve ter ao menos 8 caracteres",
                     failure: password.count < 8,
                     isSecure: true)
    }}

extension SingUpView {
    var documentField: some View {
        EditTextView(text: $document,
                     placeholder: "Entre com o seu CPF *",
                     keyboard: .numberPad,
                     error: "CPF inválido",
                     failure: document.count != 11 )
        //TODO: mask
        //TODO: isDisabled
    }}

extension SingUpView {
    var phoneField: some View {
        EditTextView(text: $phone,
                     placeholder: "Entre com o seu celular *",
                     keyboard: .numberPad,
                     error: "Entre com o DDD +8 ou 9 digitos",
                     failure: phone.count < 10 || phone.count >= 12 )
        //TODO: mask
        
    }}

extension SingUpView {
    var birthdayField: some View {
        EditTextView(text: $birthday,
                     placeholder: "Entre com a data do seu nascimento *",
                     keyboard: .numberPad,
                     error: "Data deve ser dd/MM/yyyy",
                     failure: birthday.count != 10 )
        //TODO: mask
        
    }}

extension SingUpView {
    var genderField: some View {
        Picker("Gender", selection: $gender){
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
            viewModel.singUp()
        }, disable: !email.isEmail() ||
                          password.count < 8 ||
                          fullName.count < 3 ||
                          document.count != 11 ||
                          phone.count < 10 || phone.count >= 12 ||
                          birthday.count != 10,
                          
                          showProgress: self.viewModel.uiState == SingUpUIState.loading,
                          text: "Realize seu cadastro")
        }
    }

struct SingUpView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            SingUpView(viewModel: SingUpViewModel())
                .previewDevice("Iphone 11")
                .preferredColorScheme($0)
        }
    }
}

