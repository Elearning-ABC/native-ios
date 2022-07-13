//
//  ShowChangeFontSizeView.swift
//  CodeDeLaRoute
//
//  Created by HongTuan on 23/06/2022.
//

import SwiftUI

struct ChangeFontSizeView: ViewModifier {
    @Binding var show: Bool
    
    @State var value: Double = 0.8
    @State var fontSize: Double
    
    var onChangeFontSize: (_ size: Double) -> Void
    
    private let thumbRadius: CGFloat = 30
    
    func body(content: Content) -> some View {
        ZStack {
            content
            if show{
                body
            }
        }
        .onAppear{
            value = fontSize*(0.8/14)
        }
    }
    
    func onChange(value: Double){
        fontSize = (14/0.8)*value
        onChangeFontSize(fontSize)
    }
    private var body: some View {
        ZStack {
            Color.gray.opacity(0.3).ignoresSafeArea(.all)
                .onTapGesture(perform: {
                    show.toggle()
                })
            
            HStack {
                Spacer()
                VStack {
                    Text("Change Font Size")
                        .font(.system(size: 20, weight: .semibold))
                        .padding(.vertical)
                    
                    CustomSlider(value: $value,
                                 in: 0.8...2.4,
                                 step: 0.1,
                                 onEditingChanged: {  _ in
                        
                    }, track: {
                        Capsule()
                            .foregroundColor(.gray)
                            .frame(width: Screen.width*3/4, height: 6)
                    }, fill: {
                        
                        Capsule()
                            .foregroundColor(.blue)
                        
                    }, thumb: {
                        Text(String(format: "%.1f", value))
                            .foregroundColor(.blue1)
                            .frame(width: thumbRadius, height: thumbRadius, alignment: .center)
                            .background(Color.white)
                            .cornerRadius(thumbRadius/2)
                            .shadow(color: .gray, radius: 2)
                        
                    }, thumbSize: CGSize(width: thumbRadius, height: thumbRadius))
                }
                Spacer()
            }
            .padding()
            .padding(.bottom, 40.0)
            .background(.white)
            .cornerRadius(12)
            .padding()
            
        }
        .animation(.easeOut, value: show)
        .onChange(of: value, perform: {value in
            onChange(value: value)
        })
    }
}

extension View{
    func showChangeFontSizeView(show: Binding<Bool>, fontSize: Double, onChangeFontSize: @escaping (_ size: Double) -> Void)-> some View{
        self.modifier(ChangeFontSizeView(show: show, fontSize: fontSize, onChangeFontSize: onChangeFontSize))
    }
}
