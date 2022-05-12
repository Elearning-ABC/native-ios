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
    
    var body: some View {
        ZStack {
            VStack {
                HearderQuestionView(title: title)
                        VStack{
                            BodyQuestionView(questionProgress: viewModel.listQuestionProgress[0])
                        }
                        .padding()
                FooterQuestionView()
                
            }
            
            .background(BackGroundView())
            .ignoresSafeArea()
            
            viewModel.showSucsessAnswer ?
            VStack{
                HearderQuestionView(title: title)
            }
            .background(Color.blue2)
            .ignoresSafeArea()
            : nil
        }
        
        
    }
}

struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView( title: "")
    }
}
