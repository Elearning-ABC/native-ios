//
//  QuestionView.swift
//  CodeDeLaRoute
//
//  Created by Nhung Nguyen on 27/04/2022.
//

import SwiftUI

struct QuestionView: View {
    @EnvironmentObject var viewModel : PracticeViewModel
    var body: some View {
        VStack {
            ZStack {
                if viewModel.showSucsessAnswer{
                    AnswerSuccessView()
                }else{
                    VStack {
                        HearderQuestionView(title: viewModel.process.title)
                        VStack{
                            BodyQuestionView(questionProgress: viewModel.listQuestionProgress[0])
                        }
                        .padding()
                        FooterQuestionView()
                    }
                }
            }
        }
        .background(BackGroundView())
        .ignoresSafeArea()
    }
}

struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView()
    }
}
