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
    @State var isShowBody: Bool = true
    @State var topic: Topic
    func onRight(){
        if practicViewModel.navigtorAnswer{
            isShowBody.toggle()
            withAnimation{
                practicViewModel.updateListQuestionProgress()
                isShowBody.toggle()
            }
        }
    }
    
    func onHeart(){
        practicViewModel.updateBookmark()
    }
    
    var body: some View {
        VStack {
            if practicViewModel.showSucsessAnswer{
                AnswerSuccessView(topic: $topic)
            }else{
                ZStack {
                    if !practicViewModel.questionProgressApps.isEmpty{
                        VStack(spacing: 0) {
                            HearderQuestionView(topic: topic)
                            if isShowBody{
                                VStack(spacing: 0){
                                    AnswerQuestionView<PracticeViewModel>(questionProgressApp: practicViewModel.questionProgressApps[0])
                                        .transition(.slide)
                                }
                                .padding([.top, .leading, .trailing])
                                .transition(.move(edge: .trailing))
                            }
                            
                            Spacer()
                            
                            FooterAnswerQuestionView(bookmark: practicViewModel.questionProgressApps[0].bookmark, showPopup: $showPopup, onRight: onRight, onHeart: onHeart)
                        }
                    }
                    
                    if showPopup{
                        VStack{
                            Spacer()
                        }
                        .frame(width: Screen.width, height: Screen.height)
                        .background(Color.black)
                        .opacity(0.4)
                    }
                }
                .popup(isPresented: $showPopup, type: .toast, position: .bottom,closeOnTap: false, closeOnTapOutside: true) {
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
