//
//  ProgressHalfCircleView.swift
//  CodeDeLaRoute
//
//  Created by HongTuan on 23/06/2022.
//

import SwiftUI

struct ProgressHalfCircleView: View {
    @State var progress: Double
    var total: Double
    var color: Color = Color.blue
    var size: CGFloat = 20
    var width: Double = 20
        
    var body: some View {
        ZStack {
            Circle()
                .trim(from: 0.0, to: 0.5)
                .stroke(style: StrokeStyle(lineWidth: width, lineCap: .round, lineJoin: .round))
                .foregroundColor(Color.red)
                .rotationEffect(Angle(degrees: 270.0))
                .rotation3DEffect(
                    Angle.degrees(-90), axis: (0, 0, 1))
            
            Circle()
                .trim(from: 0.0, to: CGFloat(min(self.progress/(total*2), 1.0)))
                .stroke(style: StrokeStyle(lineWidth: width, lineCap: .round, lineJoin: .round))
                .foregroundColor(Color.green)
                .rotationEffect(Angle(degrees: 270.0))
                .rotation3DEffect(
                    Angle.degrees(-90), axis: (0, 0, 1))

            HStack(spacing: 0.0) {
                Text("\(Int((progress/total)*100))")
                    .font(.system(size: size, weight: .bold))
                Text("%")
                    .font(.system(size: 12, weight: .bold))
                    .padding(.bottom, -5.0)
            }
        }
    }
}

struct ProgressHalfCircleView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressHalfCircleView(progress: 5, total: 10)
    }
}
