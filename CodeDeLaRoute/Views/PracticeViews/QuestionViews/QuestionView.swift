//
//  QuestionView.swift
//  CodeDeLaRoute
//
//  Created by Nhung Nguyen on 27/04/2022.
//

import SwiftUI
import PopupView

struct QuestionView: View {
    @EnvironmentObject var viewModel : PracticeViewModel
    @State var showPopup: Bool = false
    @State var isShowBody: Bool = true
    @State var topic: Topic
    func onRight(){
        if viewModel.navigtorAnswer{
            isShowBody.toggle()
            withAnimation{
                viewModel.updateListQuestionProgress()
                isShowBody.toggle()
            }
        }
    }
    
    func onHeart(){
        viewModel.updateBookmark()
    }
    
    var body: some View {
        VStack {
            if viewModel.showSucsessAnswer{
                AnswerSuccessView(topic: $topic)
            }else{
                ZStack {
                    if !viewModel.questionProgressApps.isEmpty{
                        VStack(spacing: 0) {
                            HearderQuestionView(topic: topic)
                            if isShowBody{
                                VStack(spacing: 0){
                                    AnswerQuestionView<PracticeViewModel>(questionProgressApp: viewModel.questionProgressApps[0])
                                        .transition(.slide)
                                }
                                .padding([.top, .leading, .trailing])
                                .transition(.move(edge: .trailing))
                            }
                            
                            Spacer()
                            
                            FooterAnswerQuestionView(bookmark: viewModel.questionProgressApps[0].bookmark, showPopup: $showPopup, onRight: onRight, onHeart: onHeart)
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
            viewModel.getQuestionProgressApps(topicId: topic.id)
        }
    }
}

struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView(topic: Topic()).environmentObject(PracticeViewModel())
    }
}
