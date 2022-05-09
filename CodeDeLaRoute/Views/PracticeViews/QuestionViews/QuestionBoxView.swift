//
//  QuestionBoxView.swift
//  CodeDeLaRoute
//
//  Created by Nhung Nguyen on 27/04/2022.
//

import SwiftUI

struct QuestionBoxView: View {
    @EnvironmentObject var viewModel : PracticeViewModel
    var question: String
    var iconName: String
    var boxNum: Int
        
    var body: some View {
        let content = viewModel.getStatus(boxNum: boxNum)
        ZStack(alignment: .topLeading) {
            VStack {
                HStack(alignment: .center) {
                    Text(question)
                        .font(.system(size: 18))
                    Spacer()
                    if iconName != ""{
                        Image(iconName)
                            .resizable()
                            .frame(width:80,height: 80)
                    }
                    
                    
                }
            }
            .padding()
            .overlay(RoundedRectangle(cornerRadius: 16)
                        .stroke(content.color, lineWidth: 1)
            )
            
            VStack {
                Text(content.status)
                    .font(.system(size: 16, weight: .semibold))
                    .padding(.horizontal, 8.0)
                    
                
            }
            .background(                            LinearGradient(gradient: Gradient(colors: [ Color(red: 0.888, green: 0.898, blue: 0.934),Color(red: 0.922, green: 0.925, blue: 0.943)]), startPoint: .bottomLeading, endPoint: .topTrailing)
)
            .padding(.top, -8.0)
            .padding(.horizontal)
        }
        .padding(.bottom)
        
        
    }
}

struct QuestionBoxView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionBoxView(question: "What does this road sign mean?", iconName: "1322.png".replace(target: ".png", withString: ""), boxNum: 0)
    }
}
