//
//  PracticeView.swift
//  CodeDeLaRoute
//
//  Created by Nhung Nguyen on 14/04/2022.
//

import SwiftUI

@available(iOS 15.0, *)
struct PracticeView: View {
    @EnvironmentObject var viewModel : PracticeViewModel
    
    var body: some View {
        
        VStack {
            HeaderPracticeView()
  
            ScrollView{
                
                ButtonView(title: "Sart learning", color: Color.red)
                    .padding(.top)
                    .padding(.horizontal, 50.0)
                    .onTapGesture {
                        print("ok")
                    }
                
                VStack{
                    ForEach(viewModel.topics){
                        topic in
                        TopicRowView(name: topic.name, urlIcon: topic.icon, id: topic.id, totalQuestion: topic.totalQuestion)
                            .padding(.bottom, 14.0)
                        
                    }
                    
                }.padding()
            }
            .padding(.vertical, -8.0)
            Spacer()
                
        }
        
    }
}

@available(iOS 15.0, *)
struct PracticeView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            PracticeView()
        }
        
    }
}
