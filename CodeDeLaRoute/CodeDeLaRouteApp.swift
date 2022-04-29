//
//  CodeDeLaRouteApp.swift
//  CodeDeLaRoute
//
//  Created by Nhung Nguyen on 13/04/2022.
//

import SwiftUI

@available(iOS 15.0, *)
@main
struct CodeDeLaRouteApp: App {
    @StateObject var viewModel = PraticeViewModel()
    var body: some Scene {
        WindowGroup {
            NavigationView{
            ContentView()
                .environmentObject(viewModel)
                .navigationBarHidden(true)
            }
            
        }
    }
}
