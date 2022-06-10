//
//  ReviewRowView.swift
//  CodeDeLaRoute
//
//  Created by Nhung Nguyen on 07/06/2022.
//

import SwiftUI

struct ReviewRowView: View {
    @EnvironmentObject var viewModel: ReviewViewModel
    var name: String
    var imageString: String
    var listQuestionProgressApp : [QuestionProgressApp]
    @State var isActive : Bool = false
    var body: some View {
       
        NavigationLink(destination: ReviewDetailView(title: name)
                        .environmentObject(viewModel)
                        .navigationBarHidden(true)
                       ,isActive: $isActive
        ){
            VStack(alignment: .leading) {
                VStack {
                    HStack(alignment: .top) {
                        Text(name)
                            .foregroundColor(.blue1)
                            .font(.system(size: 24, weight: .semibold))
                        Spacer()
                        VStack {
                            Image(systemName: imageString)
                                .foregroundColor(.white)
                        }
                        .frame(width: 24, height: 24)
                        .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray, lineWidth: 2)
                            )
                        .background(
                            LinearGradient(gradient: Gradient(colors: [ Color("#002395")!,Color("#969BFF")!]), startPoint: .bottomLeading, endPoint: .topTrailing)
                            )
                        .cornerRadius(8)
                    }
                }
                
                DividingLineView(color: Color.blue3!)
                    .padding(.vertical, 8.0)
                Text("\(listQuestionProgressApp.count) questions")
                    .foregroundColor(.gray2)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(8)
            .padding(.bottom, 8.0)
            .onTapGesture {
                if listQuestionProgressApp.count != 0{
                    viewModel.listQuestionProgress = listQuestionProgressApp
                    isActive = true
                }else{
                    viewModel.isShowNoQuestion = true
                }
            }
        }
    }
}

struct ReviewRowView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewRowView(name: "", imageString: "",  listQuestionProgressApp: [QuestionProgressApp(questionProgress: QuestionProgress())])
    }
}
