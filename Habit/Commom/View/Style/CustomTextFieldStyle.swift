//
//  CustomTextFieldStyle.swift
//  Habit
//
//  Created by Rogério Júnior on 26/02/23.
//

import SwiftUI

struct CustomFieldStyle: TextFieldStyle {
    
    public func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(.horizontal, 8)
            .padding(.vertical, 16)
            .overlay (
                RoundedRectangle (cornerRadius: 8.0)
                    .stroke(Color.orange, lineWidth: 0.8)
            )
    }
    
}
