//
//  HideOpacity.swift
//  CodeDeLaRoute
//
//  Created by Nhung Nguyen on 08/06/2022.
//

import SwiftUI

struct HideOpacity: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .opacity(1)
            .background(Color.white)
    }
}
