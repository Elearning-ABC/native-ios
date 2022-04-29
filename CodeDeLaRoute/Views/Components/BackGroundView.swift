//
//  BackGroundView.swift
//  CodeDeLaRoute
//
//  Created by Nhung Nguyen on 21/04/2022.
//

import SwiftUI

struct BackGroundView: View {
    var body: some View {
        Image("Background")
            .resizable()
            .ignoresSafeArea()
    }
}

struct BackGroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackGroundView()
    }
}
