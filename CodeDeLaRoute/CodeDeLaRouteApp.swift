//
//  CodeDeLaRouteApp.swift
//  CodeDeLaRoute
//
//  Created by Nhung Nguyen on 13/04/2022.
//

import SwiftUI

@main
struct CodeDeLaRouteApp: App {
    @State var start = false
    @StateObject var viewModel = ViewModel()
    var body: some Scene {
        WindowGroup {
            if start{
                StartView(start: $start)
            }else{
                NavigationView{
                    ContentView()
                            .environmentObject(viewModel)
                            .navigationBarHidden(true)
                }
            }
        }
    }
}
