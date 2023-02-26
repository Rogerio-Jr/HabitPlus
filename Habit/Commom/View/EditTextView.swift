//
//  EditTextView.swift
//  Habit
//
//  Created by Rogério Júnior on 26/02/23.
//

import SwiftUI

struct EditTextView: View {
    
    @Binding var text: String
    
    var placeholder: String = ""
    var keyboard: UIKeyboardType = .default
    var error: String? = nil
    var failure: Bool? = nil
    
    
    var body: some View {
        VStack {
            TextField(placeholder, text: $text)
                .foregroundColor(Color("textColor"))
                .keyboardType(keyboard)
                .textFieldStyle(CustomFieldStyle())
        
            if let error = error, failure == true, !text.isEmpty {
                Text(error).foregroundColor(.red)
            }
        }
        .padding(.bottom, 10)
        
    }
}

struct EditText_Previews: PreviewProvider {
    static var previews: some View {
        
        ForEach(ColorScheme.allCases, id: \.self) {
            VStack {
                EditTextView(text: .constant("Texto"),
                            placeholder: "E-mail",
                            error: "Campo invalido",
                             failure: "a@a.com".count < 3)
                    .padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .previewDevice("Iphone 11")
            .preferredColorScheme($0)
        }
        
       
    }
}
