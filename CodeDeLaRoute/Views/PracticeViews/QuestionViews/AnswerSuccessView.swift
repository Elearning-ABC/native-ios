//
//  AnswerSuccessView.swift
//  CodeDeLaRoute
//
//  Created by Nhung Nguyen on 17/05/2022.
//

import SwiftUI

struct AnswerSuccessView: View {
    @EnvironmentObject var viewModel : PracticeViewModel
    @State var isActive = false
    var index: Int
    var body: some View {
        VStack {
            HStack {
                BackHearderLeftView(title: viewModel.listChildTopics[index].name)
                Spacer()
            }
            .padding(.horizontal, 24.0)
            .padding(.top, Screen.statusBarHeight)

            Text("Congratulations!")
                .foregroundColor(.blue1)
                .font(.system(size: 24, weight: .semibold))
                .padding(.bottom, 8.0)
            Text("You’ve successfully completed part \(index + 1)!")
                .font(.system(size: 16))
            
            Image("SuccessImage")
            
            Text("Let's take a look at your study progress today")
                .frame(width: 260)
                .font(.system(size: 18, weight: .semibold))
                .multilineTextAlignment(.center)
                .padding(.vertical)
            
            Spacer()
            HStack {
                HStack {
                    Spacer()
                    Text("Try again")
                        .foregroundColor(.white)
                        .font(.system(size: 16, weight: .semibold))
                    Spacer()
                }
                .padding()
                .background(Color.red)
                .cornerRadius(12)
                Spacer()
                
                NavigationLink(destination: QuestionView(title: viewModel.listChildTopics[index + 1].name, index: index + 1)
                                .environmentObject(viewModel)
                                .navigationBarHidden(true)
                               ,
                               isActive: $isActive
                ){
                
                    HStack {
                        Spacer()
                        Text("Go to part \(index + 2)")
                            .foregroundColor(.white)
                            .font(.system(size: 16, weight: .semibold))
        
                        Spacer()
                    }
                    .padding()
                    .background(Color.blue1)
                    .cornerRadius(12)
                    .onTapGesture {
                        viewModel.getListQuestion(id: viewModel.listChildTopics[index + 1].id)
                        isActive = true
                    }
                }
                
                
            }
            .padding()
            .padding(.bottom, 30.0)
        }
    }
}

struct AnswerSuccessView_Previews: PreviewProvider {
    static var previews: some View {
        AnswerSuccessView(index: 1)
    }
}
