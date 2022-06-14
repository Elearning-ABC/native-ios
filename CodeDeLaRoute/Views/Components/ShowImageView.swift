//
//  ShowImageView.swift
//  CodeDeLaRoute
//
//  Created by Nhung Nguyen on 10/06/2022.
//

import SwiftUI

struct ShowImageView: ViewModifier {
  func body(content: Content) -> some View {
    ZStack(alignment: .center, content: {
        content.layoutPriority(1)
            .blur(radius: 30).clipped()
        VStack {
            Image(systemName: "eye.slash.fill").foregroundColor(.white)
            Text("NSFW").font(.caption).bold().foregroundColor(.white)
        }
    })
  }
}

extension Image {
    func showImageView() -> some View {
        self.modifier(ShowImageView())
    }
}
