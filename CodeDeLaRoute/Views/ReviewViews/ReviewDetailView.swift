//
//  ReviewDetailView.swift
//  CodeDeLaRoute
//
//  Created by Nhung Nguyen on 07/06/2022.
//

import SwiftUI

struct ReviewDetailView: View {
    @EnvironmentObject var reviewViewModel: ReviewViewModel
    @State var isActive : Bool = false
    var title: String
    
    var body: some View {
        
        VStack{
            HStack {
                BackHearderLeftView(title: "\(title) (\(reviewViewModel.questionProgressApps.count))")
                Spacer()
            }
            
            ScrollView {
                ForEach(reviewViewModel.questionProgressApps){ questionProgressApp in
                    VStack{
                        if let question = reviewViewModel.getQuestion(questionId: questionProgressApp.questionId){
                            
                            QuestionReviewRowView(question: question, questionProgressApp: questionProgressApp, onHeart: {
                                reviewViewModel.onHeart(questionId: question.id)
                            })
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                }
            }
            Spacer()
            
            NavigationLink(
                destination: ReviewQuestionView( title: title)
                    .environmentObject(reviewViewModel)
                    .navigationBarHidden(true)
                ,isActive: $isActive
            ){
                HStack {
                    Spacer()
                    Text("Review These Questions")
                        .foregroundColor(.white)
                        .font(.title3)
                    Spacer()
                }
                .padding()
                .background(Color.blue1)
                .cornerRadius(16)
                .onTapGesture{
                    reviewViewModel.navigatorReviewQuestion()
                    isActive = true
                }
            }
        }
        .padding(.horizontal)
        .padding(.top, Screen.statusBarHeight)
        .padding(.bottom)
        .background(BackGroundView())
        .ignoresSafeArea()
    }
}

struct ReviewDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewDetailView(title: "")
    }
}
