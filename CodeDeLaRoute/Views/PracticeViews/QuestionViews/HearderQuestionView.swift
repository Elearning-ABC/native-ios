//
//  HearderQuestionView.swift
//  CodeDeLaRoute
//
//  Created by Nhung Nguyen on 29/04/2022.
//

import SwiftUI

struct HearderQuestionView: View {
    @EnvironmentObject var viewModel : PracticeViewModel
    var topic: Topic
    
    var body: some View {
        let correct = Screen.width*viewModel.getCorrectNumberInTopic(topicId: topic.id)/Double(topic.totalQuestion)
        let inCorrect = Screen.width*Double(viewModel.inCorrectNumber)/Double(topic.totalQuestion)
        let newQuestion = Screen.width - correct - inCorrect
        VStack {
            HeaderAnswerQuestionView(title: topic.name, correctNumber: 0, totalQuestion: 0,onSubmit: {})
            
            HStack {
                HStack{
                    Spacer()
                }
                .frame(width: correct, height: 4)
                .background(Color.green)
                HStack{
                  Spacer()
                }
                .frame(width: inCorrect, height: 4)
                .background(Color.yellow1)
                HStack{
                  Spacer()
                }
                .frame(width: newQuestion,height: 4)
                .background(Color.blue3)
            }.padding(.bottom)
                .padding(.top, 8.0)
            
        }
    }
}

struct HearderQuestionView_Previews: PreviewProvider {
    static var previews: some View {
        HearderQuestionView(topic: Topic())
    }
}
