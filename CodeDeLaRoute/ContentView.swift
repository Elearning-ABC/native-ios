//
//  ContentView.swift
//  CodeDeLaRoute
//
//  Created by Nhung Nguyen on 13/04/2022.
//

import SwiftUI

struct ContentView: View {
    @Namespace var namespace
    @StateObject var tabViewModel = TabViewModel()

    var body: some View {
        VStack(spacing:0){
            
            HeaderView()
            
            TabView(selection: $tabViewModel.active){
                PracticeView()
                    .environmentObject(PracticeViewModel())
                    .tag(Tabs.tab1)
                
                TestView()
                    .tag(Tabs.tab2)
                
                ReviewView()
                    .environmentObject(ReviewViewModel(namespace: namespace))
                    .tag(Tabs.tab3)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .padding(.top)
            
            
            HStack{
                    ForEach(
                        tabViewModel.TabData,
                        id: \.self
                    ) {
                        item in
                        HStack{
                            Spacer()

                            Image(item.image)
                                .renderingMode(item.active == tabViewModel.active ? .template : .original)
                                .foregroundColor(.blue1)
                            Spacer()
                        }
                        .frame(height: 60)
                        .background(.white)
                        .onTapGesture {
                            withAnimation{
                                tabViewModel.active = item.active
                            }
                        }
                    }
            }
            .padding(.bottom)
            .background(Color.white)
        }
        .background(BackGroundView())
        .ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
