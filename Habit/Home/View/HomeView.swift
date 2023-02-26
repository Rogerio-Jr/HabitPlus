//
//  HomeView.swift
//  Habit
//
//  Created by Rogério Júnior on 06/02/23.
//

import SwiftUI

struct HomeView: View {
 
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        Text("Olá Home Page")
    }
    
}

struct HomeView_Previews: PreviewProvider{
    static var previews: some View {
        HomeView(viewModel: HomeViewModel())
    }
}
