//
//  PracticeView.swift
//  CodeDeLaRoute
//
//  Created by Nhung Nguyen on 14/04/2022.
//

import SwiftUI

struct PracticeView: View {
    @EnvironmentObject var viewModel : PracticeViewModel
    
    var body: some View {
        VStack {
            ScrollView{
                VStack{
                    ForEach(viewModel.topics){
                        topic in
                        TopicRowView(topic: topic)
                            .environmentObject(viewModel)
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
