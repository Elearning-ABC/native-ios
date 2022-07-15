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
    @State var showReport: Bool = false
    @State var isShowBody: Bool = true
    
    var title: String
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    func update(){
        if reviewViewModel.navigtorAnswer{
            isShowBody.toggle()
            withAnimation{
                reviewViewModel.upDateListQuestion(mode: mode)
                isShowBody.toggle()
            }
        } 
    }
    
    func onHeart(){
        reviewViewModel.onHeart(questionProgressApp: reviewViewModel.questionProgressApps[0])
    }
    
    
    var body: some View {
        VStack(spacing: 0) {
            
            HeaderAnswerQuestionView(title: title, correctNumber: reviewViewModel.correctNumber, totalQuestion: reviewViewModel.questionProgressApps.count, showNumberCorrect: true, isProgress: true,onSubmit: {})
            if isShowBody{
                VStack{
                    AnswerQuestionView<ReviewViewModel>(questionProgressApp: reviewViewModel.questionProgressApps[0])
                        .transition(.slide)
                    
                }
                .padding(.horizontal)
                .transition(.move(edge: .trailing))
            }
                
            Spacer()
           
            FooterAnswerQuestionView(bookmark: reviewViewModel.questionProgressApps[0].bookmark, showPopup: $showReport, onRight: update, onHeart: onHeart)
            
            }
            .background(BackGroundView())
            .ignoresSafeArea()
            .popup(isPresented: $showReport, type: .toast, position: .bottom, closeOnTap: false, closeOnTapOutside: true) {
                
                    VStack{
                        Text("Report mistake")
                            .font(.title2)
                            .foregroundColor(.blue1)
                            .padding()
                        Spacer()
                    }
                    .frame(width: Screen.width, height: Screen.height/2)
                    .background(BackGroundView())
                    .cornerRadius(25,corners: [.topLeft, .topRight])
                
            }
    }
}

struct ReviewQuestionView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewQuestionView( title: "")
    }
}

