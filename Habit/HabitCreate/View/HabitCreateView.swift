//
//  HabitCreateView.swift
//  Habit
//
//  Created by Rogério Júnior on 06/07/23.
//

import SwiftUI

struct HabitCreateView: View {
  
  @ObservedObject var viewModel: HabitCreateViewModel
  
  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
  
  @State private var shouldPresentCamera = false
  
  init(viewModel: HabitCreateViewModel) {
    self.viewModel = viewModel
  }
  
  var body: some View {
    ScrollView(showsIndicators: false) {
      
      VStack(alignment: .center, spacing: 12) {

        Button(action: {
          self.shouldPresentCamera = true
        }, label: {
          VStack {
              viewModel.image!
              .resizable()
              .scaledToFit()
              .frame(width: 100, height: 100)
              .foregroundColor(.orange)
            
            Text("Clique aqui para enviar")
              .foregroundColor(Color.orange)
          }
        })
        .padding(.bottom, 12)
        .sheet(isPresented: $shouldPresentCamera) {
          ImagePickerView(image: self.$viewModel.image,
                          imageData: self.$viewModel.imageData,
                          isPresented: $shouldPresentCamera,
                          sourceType: .photoLibrary)
        }
        
      }
      
      VStack {
        TextField("Escreva aqui nome do hábito", text: $viewModel.name)
          .multilineTextAlignment(.center)
          .textFieldStyle(PlainTextFieldStyle())
        
        Divider()
          .frame(height: 1)
          .background(Color.gray)
      }.padding(.horizontal, 32)
      
      VStack {
        TextField("Escreva aqui a unidade de medida", text: $viewModel.label)
          .multilineTextAlignment(.center)
          .textFieldStyle(PlainTextFieldStyle())
        
        Divider()
          .frame(height: 1)
          .background(Color.gray)
      }.padding(.horizontal, 32)
      
        LoadingButtonView(action: {
            viewModel.save()
            
        }, disable:  self.viewModel.name.isEmpty, showProgress: self.viewModel.uiState == .loading, text: "Salvar")
        .padding(.horizontal, 16)
        .padding(.vertical, 8)

        Button("Cancelar") {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                withAnimation(.easeOut(duration: 0.15)){
                    self.presentationMode.wrappedValue.dismiss()
                }
            }
        }.padding(.vertical, 8)
        
        Spacer()
        
    }.padding(.horizontal, 8).padding(.vertical, 24).onAppear{
        viewModel.$uiState.sink { uiState in
            if uiState == .sucess {
                self.presentationMode.wrappedValue.dismiss()
            }
        }.store(in: &viewModel.cancellables)
    }
}
}
struct HabitCreateView_Previews: PreviewProvider {
  static var previews: some View {
    ForEach(ColorScheme.allCases, id: \.self) {
      HabitCreateView(viewModel: HabitCreateViewModel(interactor: HabitCreateInteractor()))
        .previewDevice("iPhone 11")
        .preferredColorScheme($0)
    }
  }
}

