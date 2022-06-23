//
//  ReviewView.swift
//  CodeDeLaRoute
//
//  Created by Nhung Nguyen on 14/04/2022.
//

import SwiftUI

struct ReviewView: View {
    @EnvironmentObject var viewModel : ReviewViewModel
    
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            ReviewRowView(name: "Weak Questions", imageString: "heart.fill", listQuestionProgressApp: viewModel.weakQuestionPs)
                

            ReviewRowView(name: "Medium Questions", imageString: "heart.fill", listQuestionProgressApp: viewModel.mediumQuestionPs)
                

            ReviewRowView(name: "Strong Questions", imageString: "heart.fill", listQuestionProgressApp: viewModel.strongQuestionPs)
                

            ReviewRowView(name: "All Familiar Questions", imageString: "heart.fill", listQuestionProgressApp: viewModel.allFamiliarQuestionPs)
                

            ReviewRowView(name: "Your Favorite Questions", imageString: "heart.fill", listQuestionProgressApp: viewModel.favoriteQuestionPs)
                
        }
        .padding(.horizontal)
        .onAppear{
            viewModel.getAllQuestion()
        }
        .toast(message: "No question available", isShowing: $viewModel.isShowNoQuestion, config: .init(textColor: .red, backgroundColor: Color.red1!,duration: Toast.short), image: imageAlert)
    }
    
    var imageAlert: Image = Image(systemName: "exclamationmark.circle")
    
}

struct ReviewView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewView()
    }
}
