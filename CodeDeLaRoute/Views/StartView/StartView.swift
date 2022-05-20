//
//  StartView.swift
//  CodeDeLaRoute
//
//  Created by Nhung Nguyen on 20/05/2022.
//

import SwiftUI

struct StartView: View {
    @State var selection: Int = 0
    @Binding var start : Bool
    let arrayNumber: [Int] = [0,1,2]
    var body: some View {
        VStack {
            TabView(selection: $selection){
                ContainerView(title1: "Pass your ASVAB", title2: "on the first try", text: "98% of our users pass their ASVAB on the first try", image: "Frame 8")
                    .tag(0)
                ContainerView(title1: "Experience the best ASVAB", title2: "simulated exams", text: "All our exam-like questions written by experts will best familiarize you with the real test format", image: "Frame9")
                    .tag(1)
                ContainerView(title1: "Get your personal", title2: "study plan automatically", text: "Based on your current level, an in-depth study plan will be generated to save extremely your time and efforts", image: "Frame10")
                    .tag(2)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            
            HStack{
                ForEach(0..<3){i in
                    Circle()
                        .frame(width: 10, height: 10)
                        .foregroundColor(i == selection ? .blue1 : .white)
                }
            }
            ButtonView(title: "Next", color: Color.blue1!)
                .padding()
                .onTapGesture {
                    if selection == 2{
                        start = false
                    }else{
                        selection += 1
                    }
                }
        }
        .background(BackGroundView())
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView(start: .constant(false))
    }
}
