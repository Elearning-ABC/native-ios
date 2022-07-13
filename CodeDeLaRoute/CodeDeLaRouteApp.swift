//
//  CodeDeLaRouteApp.swift
//  CodeDeLaRoute
//
//  Created by Nhung Nguyen on 13/04/2022.
//

import SwiftUI

@main
struct CodeDeLaRouteApp: App {
    @StateObject var viewModel = ViewModel()
    var body: some Scene {
        WindowGroup {
            if viewModel.settingApp == nil {
                StartView()
                    .environmentObject(viewModel)
            }else{
                NavigationView{
                    ContentView()
                            
                            .navigationBarHidden(true)
                }
                .showChangeFontSizeView(show: $viewModel.showChangeFontSize, fontSize: viewModel.settingApp!.fontSize, onChangeFontSize: { size in  viewModel.onChangeFontSize(size: size)})
                .environmentObject(viewModel)
            }
        }
    }
}
