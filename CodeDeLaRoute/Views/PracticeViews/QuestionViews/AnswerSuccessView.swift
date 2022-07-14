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
    @Binding var topic : Topic
    var body: some View {
        let index = viewModel.getIndexChildTopics(topicId: topic.id)
        let topic = viewModel.listChildTopics[index]
        VStack {
            HStack {
                BackHearderLeftView(title: topic.name)
                Spacer()
            }
            .padding(.horizontal, 24.0)
            .padding(.top, Screen.statusBarHeight)
            
            Text("Congratulations!")
                .foregroundColor(.blue1)
                .font(.system(size: 24, weight: .semibold))
                .padding(.bottom, 8.0)
            HStack {
                Text("You’ve successfully completed")
                    .font(.system(size: 16))
                Text("\(topic.name)!")
                    .textCase(.lowercase)
                    .font(.system(size: 16))
            }
            
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
                .onTapGesture {
                    viewModel.tryAgain()
                }
                Spacer()
                
                if index < viewModel.listChildTopics.count - 1{
                    NavigationLink(destination: QuestionView(topic: viewModel.listChildTopics[index + 1])
                        .environmentObject(viewModel)
                        .navigationBarHidden(true)
                    ){
                        HStack {
                            Spacer()
                            Text("Go to")
                                .foregroundColor(.white)
                                .font(.system(size: 16, weight: .semibold))
                            Text("\(viewModel.listChildTopics[index + 1].name)")
                                .textCase(.lowercase)
                                .foregroundColor(.white)
                                .font(.system(size: 16, weight: .semibold))
                            Spacer()
                        }
                        .padding()
                        .background(Color.blue1)
                        .cornerRadius(12)
                        .onTapGesture {
                            self.topic = viewModel.listChildTopics[index + 1]
                            viewModel.getQuestionProgressApps(topicId: self.topic.id)
                        }
                    }
                }
            }
            .padding()
            .padding(.bottom, 30.0)
        }
    }
}

//struct AnswerSuccessView_Previews: PreviewProvider {
//    static var previews: some View {
//        AnswerSuccessView(topic: Topic())
//    }
//}
