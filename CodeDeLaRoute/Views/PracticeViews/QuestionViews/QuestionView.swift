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
    var body: some View {
        VStack {
            if viewModel.showSucsessAnswer{
                AnswerSuccessView()
            }else{
                ZStack {
                    VStack(spacing: 0) {
                        HearderQuestionView(title: viewModel.process.title)
                        VStack(spacing: 0){
                            BodyQuestionView(questionProgress: viewModel.listQuestionProgress[0])
                                .transition(.slide)
                        }
                        .padding([.top, .leading, .trailing])
                        FooterQuestionView(showPopup: $showPopup)
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
                    
                    PopupView(showPopup: $showPopup){
                        VStack{
                            Text("Report mistake")
                                .font(.title2)
                                .foregroundColor(.blue1)
                                .padding()
                            Spacer()
                        }
                        .frame(width: Screen.width, height: Screen.height/2)
                        .background(BackGroundView())
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
        QuestionView().environmentObject(PracticeViewModel())
    }
}
