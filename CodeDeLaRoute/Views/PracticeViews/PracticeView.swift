//
//  PracticeView.swift
//  CodeDeLaRoute
//
//  Created by Nhung Nguyen on 14/04/2022.
//

import SwiftUI

struct PracticeView: View {
    @EnvironmentObject var practiceViewModel : PracticeViewModel
    var body: some View {
        VStack {
            ScrollView{
                VStack{
                    ForEach(practiceViewModel.parentTopics){
                        topic in
                        TopicRowView(topic: topic)
                            .padding(.bottom, 14.0)
                    }

                }.padding()
            }
        }
    }
}

struct PracticeView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            PracticeView()
        }
        
    }
}
