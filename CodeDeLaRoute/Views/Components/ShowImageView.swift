//
//  ShowImageView.swift
//  CodeDeLaRoute
//
//  Created by Nhung Nguyen on 10/06/2022.
//

import SwiftUI

struct ShowImageView: ViewModifier {
    @Binding var show: Bool
    var image: String
    var namespace: Namespace.ID
    var id: String
    @State var scale: CGFloat = 1
    
    func body(content: Content) -> some View {
      ZStack {
        content
        imageView
      }
    }

    private var imageView: some View {
      ZStack {
          if show{
            ZStack {
                Color.gray.opacity(0.6).ignoresSafeArea(.all)
                ZStack{
                    Image(image)
                        .resizable()
                        .matchedGeometryEffect(id: id, in: namespace)
                        .scaledToFit()
                }
                .padding(.horizontal)
            }
            .onTapGesture {
                withAnimation(.easeOut){
                    show.toggle()
                }
            }
            
          }
      }
    }
          
}

extension View {
    func showImageView(show: Binding<Bool>,image: String, namespace: Namespace.ID, id: String) -> some View {
        self.modifier(ShowImageView(show: show,image: image, namespace: namespace, id: id))
    }
}
