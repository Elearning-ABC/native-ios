//
//  CodeDeLaRouteApp.swift
//  CodeDeLaRoute
//
//  Created by Nhung Nguyen on 13/04/2022.
//

import SwiftUI

@main
struct CodeDeLaRouteApp: App {
    @Namespace var namespace
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(ViewModel(namespace: namespace))
        }
    }
}
