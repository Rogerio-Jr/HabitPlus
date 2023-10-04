//
//  HomeView.swift
//  Habit
//
//  Created by Rogério Júnior on 06/02/23.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var viewModel: HomeViewModel
    @State var selection = 0
    
    var body: some View {
        TabView(selection: $selection){
           
            viewModel.habitView()
            
                .tabItem{
                    Image(systemName: "square.grid.2x2")
                    Text("Hábitos")
                }.tag(0)
            
            viewModel.habitForChartView()
                .tabItem{
                    Image(systemName: "chart.bar")
                    Text("Gráficos")
                }.tag(1)
            
            viewModel.profileView()
                .tabItem{
                    Image(systemName: "person.crop.circle")
                    Text("Perfil")
                }.tag(2)
            
        }
        .background(Color.white)
        .accentColor(Color.orange)
}
}

struct HomeView_Previews: PreviewProvider{
    static var previews: some View {
        HomeView(viewModel: HomeViewModel())
    }
}
