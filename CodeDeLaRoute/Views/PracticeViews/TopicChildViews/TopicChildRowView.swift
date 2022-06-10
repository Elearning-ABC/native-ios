//
//  TopicChildRowView.swift
//  CodeDeLaRoute
//
//  Created by Nhung Nguyen on 22/04/2022.
//

import SwiftUI

struct TopicChildRowView: View {
    @EnvironmentObject var viewModel : PracticeViewModel
    @State var isActive: Bool = false
    var topic: Topic
    var index: Int
    var body: some View {
        let indexTopicProgress = viewModel.getIndexTopicProgress(id: topic.id)
        let value = Double(viewModel.listTopicProgress[indexTopicProgress].correctNumber)
        let total = Double(viewModel.listTopicProgress[indexTopicProgress].totalQuestionNumber)
        NavigationLink(destination:
                        QuestionView()
                        .environmentObject(viewModel)
                        .navigationBarHidden(true)
                       ,
                       isActive: $isActive
        ){
            VStack(alignment: .leading) {
                Text(topic.name)
                    .foregroundColor(.black)
                    .font(.system(size: 18, weight: .semibold))
                Text("\(topic.totalQuestion) questions sans limite de temps")
                    .foregroundColor(.gray)
                    .font(.system(size: 14))
                    .padding(.bottom)
                ProgressView(value: value, total: total)
                    .accentColor(Color.blue1)
                    .background(Color.blue3)
                      .frame(height: 8.0)
                      .scaleEffect(x: 1, y: 2, anchor: .center)
                  .clipShape(RoundedRectangle(cornerRadius: 4))
            }
            .padding()
            .background(Color.white)
            .cornerRadius(8)
            .shadow(color: .blue3!, radius: 5, x: 0, y: 14)
            .onTapGesture {
                viewModel.process.indexTopic = indexTopicProgress
                viewModel.process.indexListChildTopic = index
                viewModel.process.title = topic.name
                viewModel.getListQuestion(id: topic.id)
                isActive = true
            }
        }
        
        
    }
}

struct TopicChildRowView_Previews: PreviewProvider {
    static var previews: some View {
        TopicChildRowView(topic: Topic(), index: 0)
    }
}
