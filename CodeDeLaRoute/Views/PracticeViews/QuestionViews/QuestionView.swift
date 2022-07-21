//
//  QuestionView.swift
//  CodeDeLaRoute
//
//  Created by Nhung Nguyen on 27/04/2022.
//

import SwiftUI
import PopupView

struct QuestionView: View {
    @EnvironmentObject var practicViewModel : PracticeViewModel
    @State var showPopup: Bool = false
    @State var topic: Topic
    
    func onHeart(){
        practicViewModel.onHeart()
    }
    
    var body: some View {
        VStack {
            if practicViewModel.showSucsessAnswer{
                AnswerSuccessView(topic: $topic)
            }else{
                    if !practicViewModel.questionProgressApps.isEmpty{
                        let questionProgressApp = practicViewModel.questionProgressApps[0]
                        VStack(spacing: 0) {
                            HearderQuestionView(topic: topic)
                            AnswerQuestionView<PracticeViewModel>(questionProgressApp: questionProgressApp,question: questionProgressApp.question!,answers: questionProgressApp.answers!, bookmark: questionProgressApp.bookmark, onHeart: onHeart)
                        }
                    }
            }
        }
        .background(BackGroundView())
        .ignoresSafeArea()
        .onAppear{
            practicViewModel.getQuestionProgressApps(topicId: topic.id)
        }
    }
}

struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView(topic: Topic()).environmentObject(PracticeViewModel())
    }
}
