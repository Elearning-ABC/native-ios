//
//  QuestionView.swift
//  CodeDeLaRoute
//
//  Created by Nhung Nguyen on 27/04/2022.
//

import SwiftUI

struct QuestionView: View {
    @EnvironmentObject var viewModel : PracticeViewModel
    var title: String
    var index: Int
    
    var body: some View {
        VStack {
            ZStack {
                viewModel.showSucsessAnswer ? nil
                :
                VStack {
                    HearderQuestionView(title: title)
                    VStack{
                        BodyQuestionView(questionProgress: viewModel.listQuestionProgress[0])
                    }
                    .padding()
                    FooterQuestionView()
                }
                
                
                viewModel.showSucsessAnswer ?
                VStack{
                    AnswerSuccessView(index: index)
                }
                : nil
            }
        }
        .background(BackGroundView())
        .ignoresSafeArea()
    }
}

struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView( title: "", index: 0)
    }
}
