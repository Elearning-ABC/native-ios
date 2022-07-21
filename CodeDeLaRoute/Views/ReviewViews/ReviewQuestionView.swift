//
//  ReviewQuestionView.swift
//  CodeDeLaRoute
//
//  Created by Nhung Nguyen on 09/06/2022.
//

import SwiftUI

struct ReviewQuestionView: View {
    @Namespace var namespace
    @EnvironmentObject var reviewViewModel: ReviewViewModel
    
    var title: String
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    func onHeart(questionId: String){
        reviewViewModel.onHeart(questionId: questionId)
    }
    
    
    var body: some View {
        let questionProgressApp = reviewViewModel.questionProgressApps[0]
        
        VStack(spacing: 0) {
            
            HeaderAnswerQuestionView(title: title, correctNumber: reviewViewModel.correctNumber, totalQuestion: reviewViewModel.questionProgressApps.count, showNumberCorrect: true, isProgress: true,onSubmit: {})
            
            AnswerQuestionView<ReviewViewModel>(questionProgressApp: questionProgressApp,question: questionProgressApp.question!,answers:   questionProgressApp.answers!, bookmark: questionProgressApp.bookmark, onHeart: {onHeart(questionId: questionProgressApp.questionId)})
        }
        .background(BackGroundView())
        .ignoresSafeArea()
        .onDisappear{
            reviewViewModel.resetReviewAnswer()
        }
        .onChange(of: reviewViewModel.isBack, perform: { _ in
            mode.wrappedValue.dismiss()
        })
    }
}

struct ReviewQuestionView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewQuestionView( title: "")
    }
}

