//
//  PracticeEndView.swift
//  CodeDeLaRoute
//
//  Created by HongTuan on 23/06/2022.
//

import SwiftUI

struct PracticeEndView: View {
    @EnvironmentObject var viewModel : PracticeViewModel
    var PracticEndNotUEnough = PracticeEnd(lable: "Not enough to pass :(", text: "Yowch! That hurt. Failing an exam always does. But hey, that was just one try. Get your notes together and try again. You can do it!", image: "SuccessImage1")
    var PracticEndEnough = PracticeEnd(lable: "Such an excellent performance!", text: "Good job! You've successfully passed your test. Let's ace all the tests available to increase your passing possibility!", image: "SuccessImage1")
    
    
    var body: some View {
        let progress = Double(viewModel.listTopicProgress[viewModel.process.indexParentTopic].correctNumber)
        let total = Double(viewModel.listTopicProgress[viewModel.process.indexParentTopic].totalQuestionNumber)
        VStack {
            HStack {
                BackHearderLeftView(title: viewModel.process.title)
                Spacer()
            }
            .padding(.horizontal, 24.0)
            .padding(.top, Screen.statusBarHeight)
            
            VStack{
                ProgressHalfCircleView(progress: progress, total: total)
            }
            .frame(width: Screen.width/2, height: Screen.width/2, alignment: .center)
            .padding(.bottom, -Screen.width/4+40)
            
            HStack {
                VStack {
                    Text(PracticEndEnough.lable)
                        .foregroundColor(.blue1)
                        .font(.system(size: 24, weight: .bold))
                        .padding(.bottom)
                    Text(PracticEndNotUEnough.text)
                        .font(.system(size: 16))
                }
                Image(PracticEndEnough.image)
            }
            .padding()
            
            ScrollView{
                ForEach(viewModel.listChildTopics){ topic in
                    ReviewTopicRowView(topic: topic)
                }
            }
            .padding()
            VStack{
                HStack{
                    Button(action: {
                        
                    }, label: {
                        HStack{
                            Spacer()
                            Text("Review")
                                .foregroundColor(.black)
                                .font(.system(size: 16, weight: .bold))
                            Spacer()
                        }
                        .padding()
                        .background(Color.blue3)
                        .cornerRadius(12)
                    })
                    Button(action: {
                        
                    }, label: {
                        HStack{
                            Spacer()
                            Text("Try Again")
                                .foregroundColor(.white)
                                .font(.system(size: 16, weight: .bold))
                            Spacer()
                        }
                        .padding()
                        .background(Color.red)
                        .cornerRadius(12)
                    })
                }
                
                Button(action: {
                    
                }, label: {
                    HStack{
                        Spacer()
                        Text("Continue")
                            .foregroundColor(.white)
                            .font(.system(size: 16, weight: .bold))
                        Spacer()
                    }
                    .padding()
                    .background(Color.blue1)
                    .cornerRadius(12)
                })
            }
            .padding()
        }
        .background(BackGroundView())
    }
}

struct PracticeEndView_Previews: PreviewProvider {
    static var previews: some View {
        PracticeEndView()
    }
}

struct PracticeEnd{
    var lable: String
    var text: String
    var image: String
}
