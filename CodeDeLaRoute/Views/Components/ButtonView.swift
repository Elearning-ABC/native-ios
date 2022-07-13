//
//  ButtonView.swift
//  CodeDeLaRoute
//
//  Created by Nhung Nguyen on 21/04/2022.
//

import SwiftUI

struct ButtonView: View {
    var title : String
    var color: Color
    var body: some View {
        Text(title)
            .padding()
            .frame(maxWidth: .infinity)
            .foregroundColor(.white)
            .font(.system(size: 16, weight: .bold))
            .background(color)
            .cornerRadius(12)
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView(title: "Button", color: Color.red)
    }
}
