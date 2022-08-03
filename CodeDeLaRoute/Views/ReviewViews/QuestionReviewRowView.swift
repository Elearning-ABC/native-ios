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
    @State var answers: [Answer]
    var progress: [Int]
    var bookmark: Bool
    var index: Int?
    var inCorrectAnswerId: String = ""
    @State var showAnswer = false
    @State var showImage : Bool = false
    var onHeart: () -> Void
    
    func onAppear(){
        answers = answers.sorted(by: {$0.id > $1.id})
    }
    
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                if let index = index {
                    Text("\(index):")
                }
                ListProgressView(progress: progress)
                Spacer()
                BookmarkView(bookmark: bookmark, onHeart: onHeart)
            }
            .padding(.bottom, 8.0)
            Button{
                withAnimation(.easeInOut){
                    showAnswer.toggle()
                }
            }label: {
                HStack(alignment: .top) {
                    TextWithImageView(text: question.text.htmlToString)
                        .foregroundColor(.black)
                        .font(.system(size: 18))
                    Spacer()
                    if question.image != ""{
                        ImageQuestionView(imageName: question.image)
                    }
                }
            }
            .buttonStyle(HideOpacity())
            
            if showAnswer{
                VStack(alignment: .leading, spacing: 8) {
                    ForEach(answers, id: \.self){ answer in
                        if answer.id == inCorrectAnswerId && !answer.isCorrect{
                            HStack{
                                TextWithImageView(text: answer.text)
                                Spacer()
                            }
                            .padding()
                            .overlay(RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.red, lineWidth: 1)
                            )
                            .cornerRadius(12)
                        }else{
                            if answer.isCorrect{
                                VStack(alignment: .leading){
                                    TextWithImageView(text: answer.text)
                                    DividingLineView()
                                    TextWithImageView(text: question.explanation.htmlToString)
                                }
                                .padding()
                                .overlay(RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.green, lineWidth: 1)
                                )
                                .cornerRadius(12)
                            }else{
                                HStack{
                                    TextWithImageView(text: answer.text)
                                }
                                .padding()
                            }
                        }
                    }
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(8)
        .onAppear(perform: onAppear)
    }
}

struct QuestionReviewRowView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionReviewRowView(question: Question(), answers: [
            Answer()], progress: []
                              , bookmark: false, onHeart: {})
    }
}


struct BookmarkView: View {
    @State var bookmark: Bool
    var onHeart: () -> Void
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
        .onTapGesture {
            bookmark.toggle()
            onHeart()
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
