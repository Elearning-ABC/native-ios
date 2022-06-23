//
//  TopicChildView.swift
//  CodeDeLaRoute
//
//  Created by Nhung Nguyen on 21/04/2022.
//

import SwiftUI

struct TopicChildView: View {
    @EnvironmentObject var viewModel : PracticeViewModel
    @State var childrenTopics = [Topic]()
    var topic: Topic

    var body: some View {
        let value = Double(viewModel.listTopicProgress[viewModel.process.indexParentTopic].correctNumber)
        let total = Double(viewModel.listTopicProgress[viewModel.process.indexParentTopic].totalQuestionNumber)
        
        VStack(spacing: 0) {
            HStack {
                BackHearderLeftView(title: topic.name, color: Color.blue1!)
                Spacer()
            }
            .padding(.horizontal, 24.0)
            .padding(.bottom)
            
            VStack {
                ProgressView(value: value, total: total)
                    .accentColor(Color.blue1)
                    .background(Color.blue3)
                      .frame(height: 8.0)
                      .scaleEffect(x: 1, y: 2, anchor: .center)
                  .clipShape(RoundedRectangle(cornerRadius: 4))
                  .padding(.bottom)
                
                HStack() {
                    VStack(alignment: .leading) {
                        Text("Total")
                            .foregroundColor(.blue2)
                            .font(.system(size: 18, weight: .medium))
                            .padding(.bottom)
                        Text("Answered")
                            .foregroundColor(.blue2)
                            .font(.system(size: 18, weight: .medium))

                    }
                    .padding(.trailing)
                    
                    VStack(alignment: .leading) {
                        Text(String(Int(total)))
                            .foregroundColor(.blue1)
                            .font(.system(size: 24, weight: .bold))
                            .padding(.bottom, 8.0)
                        HStack(alignment: .top) {
                            Text(String(Int(value)))
                                .foregroundColor(.blue1)
                            .font(.system(size: 24, weight: .bold))
                            Image(systemName: "checkmark")
                                .foregroundColor(.blue1)
                                .padding([.top, .leading], -8.0)
                        }

                    }
                    Spacer()
                }
            }
            .padding(.horizontal, 24.0)
            .padding(.bottom, 70.0)
            
            VStack {
                ScrollView(showsIndicators: false){
                    ForEach(childrenTopics){
                        topic in
                        let index = childrenTopics.firstIndex(where: {$0.id == topic.id})
                        TopicChildRowView(topic: topic, index: index!)
                                .padding(.bottom, 14.0)
                    }
                }
                Spacer()
            }
            .padding(.horizontal, 20.0)
            .padding(.top, 40.0)
            .background(Color.white.opacity(0.6))
            .cornerRadius(25, corners: [.topLeft, .topRight])
            
        }.padding(.top, Screen.statusBarHeight)
         .background(BackGroundView())
         .ignoresSafeArea()
         .onAppear{
             childrenTopics = viewModel.getTopicsWithId(id: topic.id)

             if childrenTopics != viewModel.listChildTopics{
                 childrenTopics = viewModel.getTopicsWithId(id: topic.id)
                 viewModel.listChildTopics = childrenTopics
                 let indexTopicProgressApp = viewModel.getIndexTopicProgress(id: topic.id)
                 viewModel.process.indexParentTopic = indexTopicProgressApp
             }
         }
    }
}

struct TopicChildView_Previews: PreviewProvider {
    static var previews: some View {
        TopicChildView(topic: Topic())
    }
}
