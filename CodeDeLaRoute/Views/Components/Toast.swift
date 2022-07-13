//
//  Toast.swift
//  CodeDeLaRoute
//
//  Created by Nhung Nguyen on 10/06/2022.
//

import SwiftUI
enum AlertType{
    case error, warning, success
}

struct Toast: ViewModifier {
    // these correspond to Android values f
    // or DURATION_SHORT and DURATION_LONG
    static let short: TimeInterval = 2
    static let long: TimeInterval = 3.5
    
    let message: String
    @Binding var isShowing: Bool
    let config: Config
    let alertType: AlertType
    
    func body(content: Content) -> some View {
        ZStack {
            content
            toastView
        }
    }
    
    private var toastView: some View {
        VStack {
            if isShowing {
                HStack {
                    switch alertType {
                    case .warning:
                        Image(systemName: "exclamationmark.triangle")
                            .foregroundColor(config.textColor)
                    case .success:
                        Text("")
                    case .error:
                        Image(systemName: "exclamationmark.circle")
                            .foregroundColor(config.textColor)
                    }
                    Text(message)
                        .multilineTextAlignment(.center)
                        .foregroundColor(config.textColor)
                        .font(config.font)
                        .padding(8)
                    Spacer()
                }
                .padding(.horizontal)
                .background(config.backgroundColor)
                .cornerRadius(8)
                .onTapGesture {
                    isShowing = false
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + config.duration) {
                        isShowing = false
                    }
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 18)
        .animation(config.animation, value: isShowing)
        .transition(config.transition)
    }
    
    struct Config {
        let textColor: Color
        let font: Font
        let backgroundColor: Color
        let duration: TimeInterval
        let transition: AnyTransition
        let animation: Animation
        
        init(textColor: Color = .white,
             font: Font = .system(size: 14),
             backgroundColor: Color = .black.opacity(0.588),
             duration: TimeInterval = Toast.short,
             transition: AnyTransition = .opacity,
             animation: Animation = .linear(duration: 0.3)) {
            self.textColor = textColor
            self.font = font
            self.backgroundColor = backgroundColor
            self.duration = duration
            self.transition = transition
            self.animation = animation
        }
    }
}

extension View {
    func toast(message: String,
               isShowing: Binding<Bool>,
               config: Toast.Config,
               alertType: AlertType) -> some View {
        self.modifier(Toast(message: message,
                            isShowing: isShowing,
                            config: config, alertType: alertType))
    }
    
    func toast(message: String,
               isShowing: Binding<Bool>,
               duration: TimeInterval, alertType: AlertType) -> some View {
        self.modifier(Toast(message: message,
                            isShowing: isShowing,
                            config: .init(duration: duration), alertType: alertType))
    }
}
