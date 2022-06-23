//
//  ReviewTopicRow.swift
//  CodeDeLaRoute
//
//  Created by HongTuan on 23/06/2022.
//

import SwiftUI

struct ReviewTopicRowView: View {
    @EnvironmentObject var viewModel : PracticeViewModel
    var topic: Topic
    var body: some View {
        let indexTopicProgress = viewModel.getIndexTopicProgress(id: topic.id)
        let value = Double(viewModel.listTopicProgress[indexTopicProgress].correctNumber)
        let total = Double(viewModel.listTopicProgress[indexTopicProgress].totalQuestionNumber)
        VStack(alignment: .leading) {
            HStack{
                Text(topic.name)
                    .foregroundColor(.black)
                    .font(.system(size: 18, weight: .semibold))
                Spacer()
                Text("\(value/total)%")
                    .foregroundColor(.gray)
                    .font(.system(size: 16))
            }
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
    }
}

struct ReviewTopicRow_Previews: PreviewProvider {
    static var previews: some View {
        ReviewTopicRowView(topic: Topic())
    }
}
