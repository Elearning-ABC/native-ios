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
    var title: String
    var total: Int
    var id: String
    var body: some View {
        NavigationLink(destination: QuestionView(title: title)
                        .environmentObject(viewModel)
                        .navigationBarHidden(true)
                       ,
                       isActive: $isActive
        ){
            VStack(alignment: .leading) {
                Text(title)
                    .foregroundColor(.black)
                    .font(.system(size: 18, weight: .semibold))
                Text("\(total) questions sans limite de temps")
                    .foregroundColor(.gray)
                    .font(.system(size: 14))
                    .padding(.bottom)
                ProgressView(value: 5, total: 10)
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
                viewModel.getListQuestion(id: id)
                isActive = true
            }
        }
        
        
    }
}

struct TopicChildRowView_Previews: PreviewProvider {
    static var previews: some View {
        TopicChildRowView(title: "Test", total: 5, id: "")
    }
}
