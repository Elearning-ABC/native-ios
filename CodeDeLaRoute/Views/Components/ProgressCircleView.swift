//
//  ProgressCircle.swift
//  CodeDeLaRoute
//
//  Created by Nhung Nguyen on 19/04/2022.
//

import SwiftUI

struct ProgressCircle: View {
    @State var progress: Double
    var total: Double
    var color: Color = Color.blue
        
        var body: some View {
            ZStack {
                Circle()
                    .stroke(lineWidth: 20.0)
                    .opacity(0.3)
                    .foregroundColor(color)
                
                Circle()
                    .trim(from: 0.0, to: CGFloat(min(self.progress/total, 1.0)))
                    .stroke(style: StrokeStyle(lineWidth: 20.0, lineCap: .round, lineJoin: .round))
                    .foregroundColor(color)
                    .rotationEffect(Angle(degrees: 270.0))
                    .animation(.linear)
                    .rotation3DEffect(
                        Angle.degrees(180), axis: (0, 1, 0))

                Text(String(Int(self.progress)))
                    .font(.largeTitle)
                    .bold()
            }
        }
}

struct ProgressCircle_Previews: PreviewProvider {
    static var previews: some View {
        ProgressCircle(progress: 2, total: 10)
    }
}
