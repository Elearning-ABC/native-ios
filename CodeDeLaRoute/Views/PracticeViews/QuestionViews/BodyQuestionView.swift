//
//  BodyQuestionView.swift
//  CodeDeLaRoute
//
//  Created by Nhung Nguyen on 29/04/2022.
//

import SwiftUI

struct BodyQuestionView: View {
    @EnvironmentObject var viewModel : PracticeViewModel
    var questionProgress: QuestionProgressApp
    var body: some View {
        let question = viewModel.getQuestion(id: questionProgress.questionId)
        VStack {
            QuestionBoxView(question: question.text, iconName: question.image.replace(target: ".png", withString: ""), boxNum: question.status)
            
            if viewModel.inCorrectAnswer != ""{
                HStack{
                    Text(viewModel.inCorrectAnswer)
                        .font(.system(size: 16))
                        .multilineTextAlignment(.leading)
                        .padding(.leading)
                    Spacer()
                }
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 8)
                     .stroke(Color.red, lineWidth: 1))
                .background(Color.white)
                .cornerRadius(8)
            }
            
            
            if viewModel.showCorrectAnswer{
                VStack(alignment: .leading){
                    Text(viewModel.correctAnswer)
                        .font(.system(size: 16))
                        .multilineTextAlignment(.leading)
                        .padding(.leading)
                    DividingLineView()
                    
                    if viewModel.showExplanation{
                        VStack(alignment: .leading){
                            Text(question.explanation)
                                .font(.system(size: 16))
                                .multilineTextAlignment(.leading)
                                .padding(.leading)
                            
                            Button{
                                withAnimation(.easeOut){
                                    viewModel.showExplanation = false
                                }
                                
                            }label: {
                                Text("Hide")
                                    .padding(.leading)
                            }
                        }
                    }else{
                        Button{
                            withAnimation(.easeOut){
                                viewModel.showExplanation = true
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
                                viewModel.correctAnswer = answer.text
                                    viewModel.showCorrectAnswer = true
                            }else{
                                
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
        BodyQuestionView(questionProgress: QuestionProgressApp(id: "", questionId: "", choiceSelectedIds: [], boxNum: 0))
    }
}
