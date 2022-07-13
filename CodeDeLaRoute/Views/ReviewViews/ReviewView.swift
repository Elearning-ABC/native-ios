//
//  ReviewView.swift
//  CodeDeLaRoute
//
//  Created by Nhung Nguyen on 14/04/2022.
//

import SwiftUI

struct ReviewView: View {
    @EnvironmentObject var reviewViewModel : ReviewViewModel
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            ReviewRowView(name: "Weak Questions", imageString: "heart.fill", listQuestionProgressApp: reviewViewModel.weakQuestionPs)
            
            
            ReviewRowView(name: "Medium Questions", imageString: "heart.fill", listQuestionProgressApp: reviewViewModel.mediumQuestionPs)
            
            
            ReviewRowView(name: "Strong Questions", imageString: "heart.fill", listQuestionProgressApp: reviewViewModel.strongQuestionPs)
            
            
            ReviewRowView(name: "All Familiar Questions", imageString: "heart.fill", listQuestionProgressApp: reviewViewModel.allFamiliarQuestionPs)
            
            
            ReviewRowView(name: "Your Favorite Questions", imageString: "heart.fill", listQuestionProgressApp: reviewViewModel.favoriteQuestionPs)
            
        }
        .padding(.horizontal)
        .onAppear{
            reviewViewModel.getAllQuestion()
        }
        .toast(message: "No question available", isShowing: $reviewViewModel.isShowNoQuestion, config: .init(textColor: .red, backgroundColor: Color.red1!,duration: Toast.short), alertType: .error)
    }
    
    
    
}

struct ReviewView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewView()
    }
}
