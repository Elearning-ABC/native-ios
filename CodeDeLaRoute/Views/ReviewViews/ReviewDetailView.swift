//
//  ReviewDetailView.swift
//  CodeDeLaRoute
//
//  Created by Nhung Nguyen on 07/06/2022.
//

import SwiftUI

struct ReviewDetailView: View {
    @EnvironmentObject var viewModel: ReviewViewModel
    @State var isActive : Bool = false
    var title: String
    
    var body: some View {
        
        VStack{
            HStack {
                BackHearderLeftView(title: "\(title) (\(viewModel.listQuestionProgress.count))")
                Spacer()
            }
            ScrollView {
                ForEach(viewModel.listQuestionProgress){ questionProgressApp in
                    VStack{
                        HStack(alignment: .top) {
                            ListProgressView(questionProgressApp: questionProgressApp)
                            Spacer()
                            BookmarkView(bookmark: questionProgressApp.bookmark, questionProgressApp: questionProgressApp)
                        }
                        .padding(.bottom, 8.0)


                        if let question = viewModel.getQuestion(questionId: questionProgressApp.questionId){
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
                    .environmentObject(viewModel)
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
                    viewModel.navigatorReviewQuestion()
                    isActive = true
                }
            }
        }
        .padding(.horizontal)
        .padding(.top, Screen.statusBarHeight)
        .padding(.bottom)
        .background(BackGroundView())
        .ignoresSafeArea()
        .showImageView(show: $viewModel.showImage, image: viewModel.imageString, namespace: viewModel.namespace, id: viewModel.imageId)
        .onAppear(){
            viewModel.resetReviewAnswer()
        }
    }
}

struct ReviewDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewDetailView(title: "")
    }
}

struct BookmarkView: View {
    @State var bookmark: Bool
    @EnvironmentObject var viewModel: ReviewViewModel
    var questionProgressApp: QuestionProgressApp
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
        }.onTapGesture {
            bookmark.toggle()
            viewModel.bookmarkToggle(questionProgressApp: questionProgressApp)
        }
    }
}

struct ListProgressView: View{
    var questionProgressApp: QuestionProgressApp
    var body: some View{
        HStack(alignment: .bottom) {
            ForEach(0..<questionProgressApp.progress.count, id: \.self){i in
                    VStack{
                        if questionProgressApp.progress[i] == 1{
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
