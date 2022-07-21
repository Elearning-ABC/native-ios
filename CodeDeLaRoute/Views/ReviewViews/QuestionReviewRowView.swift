//
//  QuestionReviewRowView.swift
//  CodeDeLaRoute
//
//  Created by Nhung Nguyen on 07/06/2022.
//

import SwiftUI

struct QuestionReviewRowView: View {
    @EnvironmentObject var viewModel: ViewModel
    var question: Question
    var questionProgressApp: QuestionProgressApp
    @State var showAnswer = false
    @State var showImage : Bool = false
    var onHeart: () -> Void
    
    var body: some View {
        let imageId = question.id
        VStack {
            HStack(alignment: .top) {
                ListProgressView(progress: questionProgressApp.progress)
                Spacer()
                BookmarkView(bookmark: questionProgressApp.bookmark)
                    .onTapGesture {
                        onHeart()
                    }
            }
            .padding(.bottom, 8.0)
            Button{
                withAnimation(.easeInOut){
                    showAnswer.toggle()
                }
            }label: {
                HStack(alignment: .top) {
                    Text(question.text)
                        .foregroundColor(.black)
                        .font(.system(size: 18))
                    Spacer()
                    if question.image != ""{
                        Image(question.image.replace(target: ".png", withString: ""))
                            .resizable()
                            .matchedGeometryEffect(id: imageId, in: viewModel.namespace)
                            .scaledToFit()
                            .frame(width:80,height: 80)
                            .onTapGesture{
                                viewModel.imageString = question.image.replace(target: ".png", withString: "")
                                viewModel.imageId = imageId
                                withAnimation(.easeOut){
                                    viewModel.showImage.toggle()
                                }
                            }
                    }
                }
            }
            .buttonStyle(HideOpacity())
            
            if showAnswer{
                VStack(alignment: .leading){
                    VStack(alignment: .leading){
                        ForEach(question.correctAnswers,id:\.self){
                            Text($0)
                        }
                        DividingLineView()
                        Text(question.explanation)
                    }
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.green, lineWidth: 1)
                    )
                    VStack(alignment: .leading, spacing: 20) {
                        ForEach(question.inCorrectAnswers, id: \.self){
                            Text($0)
                        }
                    }
                    .padding()
                    
                }
            }
        }
    }
}

struct QuestionReviewRowView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionReviewRowView(question: Question(), questionProgressApp: QuestionProgressApp(questionProgress: QuestionProgress()), onHeart: {})
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
        let end = progress.count
        let start = progress.count > 10 ? end - 10 : 0
        
        HStack(alignment: .bottom) {
            ForEach(start..<end, id: \.self){i in
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
