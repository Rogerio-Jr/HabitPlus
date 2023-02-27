//
//  LoadingButtonView.swift
//  Habit
//
//  Created by Rogério Júnior on 27/02/23.
//

import SwiftUI

struct LoadingButtonView: View {
    
    var action: () -> Void
    var disable: Bool = false
    var showProgress: Bool
    var text: String
    var body: some View {
        ZStack {
            Button(action: {
                action()
            }, label: {
                Text(showProgress ? " " : text)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .padding(.horizontal, 16)
                    .font(Font.system(.title3).bold())
                    .background(disable ? Color("lightOrange") : Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(4.0)
            }).disabled(disable || showProgress)
            
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .opacity(showProgress ? 1 : 0)
        }
    }
}

struct LoadingButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self){
            VStack {
                LoadingButtonView(action: {
                    print("ola mundo")
                },
                 disable: true,
                                  showProgress: true, text: "Entrar")
            }.padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .previewDevice("iPhone 11")
                .preferredColorScheme($0)
            }
        }
}
