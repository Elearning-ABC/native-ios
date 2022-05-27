//
//  ContentView.swift
//  CodeDeLaRoute
//
//  Created by Nhung Nguyen on 13/04/2022.
//

import SwiftUI

@available(iOS 15.0, *)
struct ContentView: View {
    @StateObject var tabViewModel = TabViewModel()
    @EnvironmentObject var viewModel : PracticeViewModel
    
    var body: some View {
        VStack(spacing:0){
            TabView(selection: $tabViewModel.active){
                PracticeView()
                    .tag(Tabs.tab1)
                TestView()
                    .tag(Tabs.tab2)
                ReviewView()
                    .tag(Tabs.tab3)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .padding(.top, -Screen.statusBarHeight)
            
            
            HStack{
                Spacer()
                    ForEach(
                        tabViewModel.TabData,
                        id: \.self
                    ) {
                        item in
                        VStack{
                            Image(item.image)
                                .renderingMode(item.active == tabViewModel.active ? .template : .original)
                                .foregroundColor(.blue1)
                        }
                        .onTapGesture {
                            tabViewModel.switchTab(tab: item.active)
                        }
                        .frame(width: 60, height: 30)
                        Spacer()
                    }
            }
            .padding(.bottom, 40.0)
            .padding(.top, 15.0)
            .background(Color.white)
                
        }
        .background(BackGroundView())
        .ignoresSafeArea()
        
    }
}

@available(iOS 15.0, *)
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
