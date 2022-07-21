//
//  MainView.swift
//  CodeDeLaRoute
//
//  Created by HongTuan on 15/07/2022.
//

import SwiftUI

struct MainView: View {
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
                    .environmentObject(ReviewViewModel())
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

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
