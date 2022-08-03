//
//  QuestionBoxView.swift
//  CodeDeLaRoute
//
//  Created by Nhung Nguyen on 27/04/2022.
//

import SwiftUI



struct QuestionBoxView: View {
    @EnvironmentObject var viewModel : ViewModel
    var question: Question
    var status: StatusQuestion?
    
    var body: some View {
        let content = setStatus(statusQuestion: status)
        let size = viewModel.settingApp?.fontSize ?? 16.0
        ZStack(alignment: .topLeading) {
            VStack(alignment: .leading) {
                HStack(alignment: .center) {
                    VStack {
                        TextWithImageView(text: question.text.htmlToString)
                            .font(.system(size: size))
                        .lineLimit(nil)
                    }
                    Spacer()
                    if question.image != ""{
                        ImageQuestionView(imageName: question.image)
                    }
                }
                
                if let content = content {
                    HStack{
                        if content.text != ""{
                            Image(content.iconName)
                                .renderingMode(.template)
                                .foregroundColor(content.color)
                            
                            Text(content.text)
                                .foregroundColor(content.color)
                                .font(.system(size: 16))
                        }
                        
                    }
                }
            }
            .padding()
            .overlay(RoundedRectangle(cornerRadius: 16)
                .stroke(content?.color ?? Color.black, lineWidth: 1)
            )
            .cornerRadius(16)
            
            if let content = content {
                VStack {
                    Text(content.status)
                        .foregroundColor(content.color)
                        .font(.system(size: 16, weight: .semibold))
                        .padding(.horizontal, 8.0)
                    
                }
                .background(LinearGradient(gradient: Gradient(colors: [ Color(red: 0.888, green: 0.898, blue: 0.934),Color(red: 0.922, green: 0.925, blue: 0.943)]), startPoint: .bottomLeading, endPoint: .topTrailing)
                )
                .padding(.top, -8.0)
                .padding(.horizontal)
            }
            
        }
        .padding(.bottom)
    }
}

struct QuestionBoxView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionBoxView(question: Question(), status: .inCorrect)
    }
}

func setStatus(statusQuestion: StatusQuestion?)-> Status?{
    guard let statusQuestion = statusQuestion else {
        return nil
    }
    switch statusQuestion {
    case .learing:
        return Status(status: "LEARNING", color: Color.yellow, iconName: "alert-circle", text: "You got this wrong last time")
    case .reviewing:
        return Status(status: "REVIEWING", color: Color.green!, iconName: "check-circle", text: "You got this question last time")
    case .correct:
        return Status(status: "CORRECT", color: Color.green!, iconName: "check-circle", text: "You will not see this question in a while")
    case .inCorrect:
        return Status(status: "INCORRECT", color: Color.red, iconName: "alert-circle", text: "You will see this question soon")
    case .newQuestion:
        return Status(status: "NEW QUESTION", color: Color.black, iconName: "", text: "")
    }
}

struct Status{
    var status: String
    var color: Color
    var iconName: String
    var text: String
}
