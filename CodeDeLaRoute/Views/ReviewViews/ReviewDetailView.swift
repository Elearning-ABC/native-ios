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
                        HStack(alignment: .top) {
                            ListProgressView(progress: questionProgressApp.progress)
                            Spacer()
                            BookmarkView(bookmark: questionProgressApp.bookmark)
                                .onTapGesture {
                                    reviewViewModel.onHeart(questionProgressApp: questionProgressApp)
                                }
                        }
                        .padding(.bottom, 8.0)


                        if let question = reviewViewModel.getQuestion(questionId: questionProgressApp.questionId){
                            
                            QuestionReviewRowView(question: question )
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
        .showImageView(show: $reviewViewModel.showImage, image: reviewViewModel.imageString, namespace: reviewViewModel.namespace, id: reviewViewModel.imageId)
        .onAppear(){
            reviewViewModel.resetReviewAnswer()
        }
    }
}

struct ReviewDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewDetailView(title: "")
    }
}

struct BookmarkView: View {
    var bookmark: Bool
    var body: some View {
        VStack{
            if bookmark
            {
                Image(systemName: "heart.fill")
                    .foregroundColor(.blue1)
                    .font(.system(size: 20))
            }else{
                Image(systemName: "heart")
                    .foregroundColor(.blue3)
                    .font(.system(size: 20))
            }
        }
    }
}

struct ListProgressView: View{
    var progress: [Int]
    
    var body: some View{
        
        HStack(alignment: .bottom) {
            ForEach(0..<progress.count, id: \.self){i in
                VStack{
                    if progress[i] == 1{
                        Image(systemName: "checkmark")
                            .foregroundColor(.green)
                            .font(.system(size: 10))
                    }else{
                        Image(systemName: "multiply")
                            .foregroundColor(.red)
                            .font(.system(size: 12))

                    }
                }
            }
        }
    }
}
