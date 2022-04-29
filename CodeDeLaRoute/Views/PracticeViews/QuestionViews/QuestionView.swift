//
//  QuestionView.swift
//  CodeDeLaRoute
//
//  Created by Nhung Nguyen on 27/04/2022.
//

import SwiftUI

struct QuestionView: View {
    @EnvironmentObject var viewModel : PraticeViewModel
    @State var selection: Int = 0
    var title: String
    
    var body: some View {
        VStack {
            HearderQuestionView(title: title)
            TabView(selection: $selection) {
                ForEach(viewModel.listQuestion.indices){
                    i in
                    VStack{
                        BodyQuestionView(index: i)
                    }
                    .padding()
                    .tag(i)
                    
                }
                
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            FooterQuestionView(selection: $selection)
            
        }
        
        .background(BackGroundView())
        .ignoresSafeArea()
        
        
    }
}

struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView( title: "")
    }
}
