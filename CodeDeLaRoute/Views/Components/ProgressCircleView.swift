//
//  ProgressCircle.swift
//  CodeDeLaRoute
//
//  Created by Nhung Nguyen on 19/04/2022.
//

import SwiftUI

struct ProgressCircleView: View {
    var progress: Double
    var total: Double
    var color: Color = Color.blue
    var width: Double = 10
    var content: AnyView?
        
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: width)
                .opacity(0.3)
                .foregroundColor(color)
            
            Circle()
                .trim(from: 0.0, to: CGFloat(min(self.progress/total, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: width, lineCap: .round, lineJoin: .round))
                .foregroundColor(color)
                .rotationEffect(Angle(degrees: 270.0))
                .animation(.linear, value: progress)
                .rotation3DEffect(
                    Angle.degrees(180), axis: (0, 1, 0))

            if let content = content {
                content
            }
        }
    }
}

struct ProgressCircle_Previews: PreviewProvider {
    static var previews: some View {
        ProgressCircleView(progress: 2, total: 10, content: AnyView(Text("okkk")))
    }
}
