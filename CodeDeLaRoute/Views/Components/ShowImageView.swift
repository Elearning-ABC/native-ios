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
                Color.black.opacity(0.6).ignoresSafeArea(.all)
                    .onTapGesture {
                        withAnimation{
                            show.toggle()
                        }
                    }
            }
            if show{
                ZStack(alignment: .topTrailing) {
                    VStack{
                        Image(image)
                            .resizable()
                            .scaledToFit()
                        
                    }
                    .padding(.horizontal)
                    .background(Color.white)
                    .cornerRadius(12)
                    
                    Image(systemName: "xmark.circle.fill")
                        .onTapGesture {
                            withAnimation{
                                show.toggle()
                            }
                        }
                        .padding(4.0)
                }
                .matchedGeometryEffect(id: id, in: namespace)
            }
        }
    }
}

extension View {
    func showImageView(show: Binding<Bool>,image: String, namespace: Namespace.ID, id: String) -> some View {
        self.modifier(ShowImageView(show: show,image: image, namespace: namespace, id: id))
    }
}
