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
                            .foregroundColor(.black)
                            .font(Font.system(.title).bold())
                            .padding(.bottom, 8)
                        
                        fullNameField
                        
                        emailField
                        
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
        TextField("", text: $fullName)
        .border(Color.orange)}}

extension SingUpView {
    var emailField: some View {
        TextField("", text: $email)
        .border(Color.orange)}}

extension SingUpView {
    var passWordFied: some View {
        SecureField("", text: $password)
            .border(Color.orange)
    }}

extension SingUpView {
    var documentField: some View {
        TextField("", text: $document)
        .border(Color.orange)}}

extension SingUpView {
    var phoneField: some View {
        TextField("", text: $phone)
        .border(Color.orange)}}

extension SingUpView {
    var birthdayField: some View {
        TextField("", text: $birthday)
        .border(Color.orange)}}

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
        Button("Realize o seu cadastro") {
            viewModel.singUp()
        }
    }
}
struct SingUpView_Previews: PreviewProvider {
    static var previews: some View {
        SingUpView(viewModel: SingUpViewModel())
    }
}

