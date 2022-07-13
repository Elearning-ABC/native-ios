//
//  ShowChangeFontSizeView.swift
//  CodeDeLaRoute
//
//  Created by HongTuan on 23/06/2022.
//

import SwiftUI

struct PopupView: ViewModifier {
    @Binding var isShow: Bool
    let view: AnyView
    func body(content: Content) -> some View {
        ZStack {
            content
            if isShow{
                body
            }
        }
    }
    
    private var body: some View {
        ZStack {
            Color.gray.opacity(0.3).ignoresSafeArea(.all)
                .onTapGesture {
                    isShow.toggle()
                }
            view
        }
    }
}

extension View{
    func popupView(isShow: Binding<Bool>, view: AnyView)-> some View{
        self.modifier(PopupView(isShow: isShow, view: view))
    }
}
