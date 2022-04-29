//
//  BodyQuestionView.swift
//  CodeDeLaRoute
//
//  Created by Nhung Nguyen on 29/04/2022.
//

import SwiftUI

struct BodyQuestionView: View {
    @EnvironmentObject var viewModel : PraticeViewModel
    var index: Int
    @State var show: Bool = false
    @State var answer: String = ""
    @State var showExplanation : Bool = false
    var body: some View {
        let question = viewModel.listQuestion[index]
        VStack {
            QuestionBoxView(question: question.text, iconName: question.image.replace(target: ".png", withString: ""), status: question.status)
            
            if show{
                VStack(alignment: .leading){
                    Text(answer)
                        .font(.system(size: 16))
                        .multilineTextAlignment(.leading)
                        .padding(.leading)
                    DividingLineView()
                    
                    if showExplanation{
                        VStack(alignment: .leading){
                            Text(question.explanation)
                                .font(.system(size: 16))
                                .multilineTextAlignment(.leading)
                                .padding(.leading)
                            
                            Button{
                                withAnimation(.easeOut){
                                    showExplanation = false
                                }
                                
                            }label: {
                                Text("Hide")
                                    .padding(.leading)
                            }
                        }
                    }else{
                        Button{
                            withAnimation(.easeOut){
                                showExplanation = true
                            }
                        }label: {
                            Text("Show Explanation")
                                .padding(.leading)
                        }
                    }
                }
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 8)
                     .stroke(Color.green, lineWidth: 1))
                .background(Color.white)
                .cornerRadius(8)
            }else{
                ForEach(viewModel.getListAnswer(id: question.id)){
                    answer in
                    AnswerView(answer: answer.text)
                        .onTapGesture {
                            if answer.isCorrect{
                                self.answer = answer.text
                                viewModel.setStatus(index: index, status: 2)
                                show = true
                            }else{
                                viewModel.setStatus(index: index, status: 3)
                            }
                        }
                }
            }
            Spacer()
            
        }
    }
}

struct BodyQuestionView_Previews: PreviewProvider {
    static var previews: some View {
        BodyQuestionView(index: 1)
    }
}
