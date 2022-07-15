//
//  QuestionReviewRowView.swift
//  CodeDeLaRoute
//
//  Created by Nhung Nguyen on 07/06/2022.
//

import SwiftUI

struct QuestionReviewRowView: View {
    var question: Question
    @EnvironmentObject var viewModel: ViewModel
    @State var showAnswer = false
    @State var showImage : Bool = false
    
    
    var body: some View {
        let imageId = question.id
        VStack {
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
        QuestionReviewRowView(question: Question())
    }
}
