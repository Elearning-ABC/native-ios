//
//  QuestionReviewRowView.swift
//  CodeDeLaRoute
//
//  Created by Nhung Nguyen on 07/06/2022.
//

import SwiftUI

struct QuestionReviewRowView: View {
    var question: Question
    @State var showAnswer = false
    
    var body: some View {
        VStack {
            Button{
                withAnimation(.easeInOut){
                    showAnswer.toggle()
                }
            }label: {
                HStack(alignment: .top) {
                    Text(question.text)
                        .foregroundColor(.black)
                        .font(.system(size: 18))
                    Spacer()
                    if question.image != ""{
                        Image(question.image.replace(target: ".png", withString: ""))
                            .resizable()
                            .frame(width:80,height: 80)
                    }
                }
            }
            .buttonStyle(HideOpacity())
            
            
            if showAnswer{
                VStack(alignment: .leading){
                    VStack(alignment: .leading){
                        ForEach(question.correctAnswers,id:\.self){
                            Text($0)
                        }
                        DividingLineView()
                        Text(question.explanation)
                    }
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.green, lineWidth: 1)
                    )
                    VStack(alignment: .leading, spacing: 20) {
                        ForEach(question.inCorrectAnswers, id: \.self){
                            Text($0)
                        }
                    }
                    .padding()
                    
                }
            }
        }
    }
}

struct QuestionReviewRowView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionReviewRowView(question: Question())
    }
}
