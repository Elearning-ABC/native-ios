//
//  CustomPopupview.swift
//  CodeDeLaRoute
//
//  Created by HongTuan on 26/07/2022.
//

import SwiftUI


struct CustomPopupView: ViewModifier {
    @Binding var isShow: Bool
    let anyView: AnyView
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
            Color.gray.opacity(0.6).ignoresSafeArea(.all)
                .onTapGesture {
                    isShow.toggle()
                }
        }
        .popup(isPresented: $isShow, type: .toast, position: .bottom, closeOnTap: false, closeOnTapOutside: true) {
            anyView
        }
    }
}

extension View{
    func popup(isShow: Binding<Bool>, anyView: AnyView)-> some View{
        self.modifier(CustomPopupView(isShow: isShow, anyView: anyView))
    }
}
