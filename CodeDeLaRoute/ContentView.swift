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
    @EnvironmentObject var viewModel : PraticeViewModel
    
    var body: some View {
        ZStack(alignment: .bottom) {
            BackGroundView()
                
            VStack{
                switch tabViewModel.active {
                        case .tab1:
                    PracticeView()
                        case .tab2:
                            TestView()
                        case .tab3:
                            ReviewView()
                        }
                
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
                .padding(.vertical, 30.0)
                .background(Color.white)
            }
        }
        .ignoresSafeArea()
    }
}

@available(iOS 15.0, *)
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
