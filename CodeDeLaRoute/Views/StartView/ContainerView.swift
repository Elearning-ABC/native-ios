//
//  ContainerView.swift
//  CodeDeLaRoute
//
//  Created by Nhung Nguyen on 20/05/2022.
//

import SwiftUI

struct ContainerView: View {
    var title1: String
    var title2: String
    var text: String
    var image: String
    var body: some View {
        VStack {
            Image(image)
                .resizable()
                .scaledToFit()
            
            Text(title1)
                .foregroundColor(.blue1)
                .font(.system(size: 26, weight: .semibold))
            Text(title2)
                .foregroundColor(.blue1)
                .font(.system(size: 26, weight: .semibold))
                .padding(.bottom, 16.0)
            
            Text(text)
                .font(.system(size: 18))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24.0)
            Spacer()
                
        }
        .padding(.top, 40.0)
    }
}

struct ContainerView_Previews: PreviewProvider {
    static var previews: some View {
        ContainerView(title1: "Pass your ASVAB", title2: "on the first try", text: "98% of our users pass their ASVAB on the first try", image: "Frame10")
    }
}
