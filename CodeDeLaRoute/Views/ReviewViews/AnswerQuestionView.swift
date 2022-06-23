//
//  AnswerQuestionView.swift
//  CodeDeLaRoute
//
//  Created by Nhung Nguyen on 08/06/2022.
//

import SwiftUI

struct AnswerQuestionView: View {
    var namespace : Namespace.ID
    @StateObject var questionViewModel = QuestionViewModel()
    @EnvironmentObject var viewModel: ReviewViewModel
    var questionProgressApp: QuestionProgressApp
    var imageId = "image_question"
    
    var body: some View {
        let Status = viewModel.status
        
        let question = questionViewModel.getQuestion(questionId: questionProgressApp.questionId)
    
        VStack {
            ZStack(alignment: .topLeading) {
                VStack(alignment: .leading) {
                    HStack(alignment: .center) {
                        Text(question.text)
                            .font(.system(size: 18))
                        Spacer()
                        if question.image != ""{
                            Image(question.image.replace(target: ".png", withString: ""))
                                .resizable()
                                .matchedGeometryEffect(id: question.id, in: viewModel.namespace)
                                .scaledToFit()
                                .frame(width:80,height: 80)
                                .onTapGesture{
                                    viewModel.imageString = question.image.replace(target: ".png", withString: "")
                                    viewModel.imageId = question.id
                                    withAnimation(.easeOut){
                                        viewModel.showImage.toggle()
                                        
                                    }
                                }
                                
                        }
                    }
                    
                    HStack{
                        if Status.text != ""{
                            Image(Status.iconName)
                                .renderingMode(.template)
                                .foregroundColor(Status.color)
                            
                            Text(Status.text)
                                .foregroundColor(Status.color)
                                .font(.system(size: 16))
                        }
                        
                    }
                }
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 16)
                            .stroke(Status.color, lineWidth: 1)
                )
                
                VStack {
                    Text(Status.status)
                        .foregroundColor(Status.color)
                        .font(.system(size: 16, weight: .semibold))
                        .padding(.horizontal, 8.0)
                        
                    
                }
                .background(                            LinearGradient(gradient: Gradient(colors: [ Color(red: 0.888, green: 0.898, blue: 0.934),Color(red: 0.922, green: 0.925, blue: 0.943)]), startPoint: .bottomLeading, endPoint: .topTrailing)
    )
                .padding(.top, -8.0)
                .padding(.horizontal)
            }
            .padding(.bottom)
            
// answer......................

            ScrollView{
                if viewModel.inCorrectAnswerText != ""{
                    HStack{
                        Text(viewModel.inCorrectAnswerText)
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
                        Text(question.correctAnswers[0])
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
                    ForEach(questionViewModel.getListAnswer(id: question.id)){
                        answer in
                        AnswerView(answer: answer.text)
                            .onTapGesture {
                                withAnimation(.easeOut){
                                    viewModel.checkAnswer(answer: answer)
                                }
                            }
                    }
                }
                
            }
        }
    }
}

//struct AnswerQuestionView_Previews: PreviewProvider {
//    @Namespace var namespace
//    static var previews: some View {
//        AnswerQuestionView(namespace: Namespace.ID, questionProgressApp: QuestionProgressApp(questionProgress: QuestionProgress()))
//    }
//}
