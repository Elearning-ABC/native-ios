//
//  HearderQuestionView.swift
//  CodeDeLaRoute
//
//  Created by Nhung Nguyen on 29/04/2022.
//

import SwiftUI

struct HearderQuestionView: View {
    @EnvironmentObject var viewModel : PracticeViewModel
    var title: String
    
    var body: some View {
        let process = viewModel.process
        let correct = Screen.width*(process.correct / process.total)
        let inCorrect = Screen.width*(process.inCorrect / process.total)
        let newQuestion = Screen.width - correct - inCorrect
        VStack {
            HStack {
                BackHearderLeftView(title: title)
                Spacer()
                
                Button{
                    
                }label: {
                    Text("aA")
                        .foregroundColor(.black)
                        .font(.system(size: 20))
                }
                
                Image("Book")
                    .renderingMode(.template)
                    .foregroundColor(.black)
            }
            .padding(.horizontal, 24.0)
            
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
        .padding(.top, Screen.statusBarHeight)
        
        
    }
}

struct HearderQuestionView_Previews: PreviewProvider {
    static var previews: some View {
        HearderQuestionView(title: "ABC")
    }
}
