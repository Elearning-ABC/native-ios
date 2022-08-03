//
//  HeaderAnswerQuestionView.swift
//  CodeDeLaRoute
//
//  Created by HongTuan on 30/06/2022.
//

import SwiftUI

struct HeaderAnswerQuestionView: View{
    @EnvironmentObject var viewModel : ViewModel
    var title: String
    var correctNumber: Int
    var totalQuestion: Int
    var showNumberCorrect: Bool = false
    var isTest: Bool = false
    var isProgress: Bool = false
    let onSubmit: (() -> Void)?
    var actionBack : (() -> Void)?
    
    var body: some View{
        VStack {
            HStack {
                BackHearderLeftView(title: title, action: actionBack)
                
                if showNumberCorrect{
                    Text("\(correctNumber)/\(totalQuestion)")
                        .font(.system(size: 20, weight: .medium))
                    
                }
                Spacer()
                
                Button{
                    viewModel.showChangeFontSize.toggle()
                }label: {
                    Text("aA")
                        .foregroundColor(.black)
                        .font(.system(size: 20))
                        .padding(.trailing)
                }
                if isTest{
                    Image("submit_test")
                        .renderingMode(.template)
                        .foregroundColor(.black)
                        .onTapGesture {
                            if let onSubmit = onSubmit {
                                onSubmit()
                            }
                        }
                }else{
                    Image("Book")
                        .renderingMode(.template)
                        .foregroundColor(.black)
                }
                
            }
            .padding(.trailing, 24.0)
            .padding(.leading)
            if isProgress{
                ProgressQuestion(correctNumber: correctNumber, totalQuestion: totalQuestion)
                    
                    .padding(.top, 8.0)
            }
        }
        .padding(.top, Screen.statusBarHeight)
    }
}

struct HeaderAnswerQuestionView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderAnswerQuestionView(title: "helo", correctNumber: 1, totalQuestion: 10, onSubmit: {})
    }
}


struct ProgressQuestion:View{
    var correctNumber: Int
    var totalQuestion: Int
    var body: some View{
        let correctWidth = (CGFloat(correctNumber)/CGFloat(totalQuestion))*Screen.width
        let unfinishedWidth = Screen.width - correctWidth
        HStack {
            HStack{
                Spacer()
            }
            .frame(width: correctWidth, height: 4)
            .background(Color.green)
            
            HStack{
                Spacer()
            }
            .frame(width: unfinishedWidth, height: 4)
            .background(Color.blue3)
        }
    }
}
