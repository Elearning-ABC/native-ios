//
//  TopicRowView.swift
//  CodeDeLaRoute
//
//  Created by Nhung Nguyen on 19/04/2022.
//

import SwiftUI

struct TopicRowView: View {
    @EnvironmentObject var practiceViewModel : PracticeViewModel
    var topic: Topic
    
    var body: some View {
        let index = practiceViewModel.getIndexTopicProgress(id: topic.id)
        let value = Double(practiceViewModel.listTopicProgress[index].correctNumber)
        let total = Double(practiceViewModel.listTopicProgress[index].totalQuestionNumber)
        let percent = 100*value/total
        
        NavigationLink(destination: TopicChildView( topic: topic)
                        .environmentObject(practiceViewModel)
                        .navigationBarHidden(true)
        ){
            VStack {
                VStack {
                    HStack(alignment: .top) {
                        Text(topic.name)
                            .foregroundColor(.blue1)
                            .font(.system(size: 24, weight: .semibold))
                        Spacer()
                        VStack {
                            SVGKFastImageViewSUI(url: .constant(URL(string: topic.icon)!), size: .constant(CGSize(width: 16,height: 16)), tintColor:  .constant(Color.white))
                                .frame(width: 16, height: 16)
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
                
                
                HStack {
                    ProgressView(value: value, total: total)
                        .accentColor(Color.blue1)
                        .background(Color.blue3)
                          .frame(height: 8.0)
                          .scaleEffect(x: 1, y: 2, anchor: .center)
                      .clipShape(RoundedRectangle(cornerRadius: 4))
                    Text(((percent != 0)&&(percent < 1) ? String(format: "%.1f", percent) : String(format: "%.0f", percent)) + "%")
                        .foregroundColor(.blue1)
                        .font(.system(size: 14))
                }
                
            }
            .padding()
            .background(Color.white)
            .cornerRadius(8)
        }
    }
}

struct TopicRowView_Previews: PreviewProvider {
    static var previews: some View {
        TopicRowView(topic: Topic())
    }
}

struct RoundedRectProgressViewStyle: ProgressViewStyle {
    func makeBody(configuration: Configuration) -> some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 4)
                .frame(height: 8)
                .foregroundColor(.blue3)
                            
            RoundedRectangle(cornerRadius: 4)
                .frame(width: CGFloat(configuration.fractionCompleted ?? 0) * 250, height: 8)
                .foregroundColor(.blue1)
        }
    }
}
