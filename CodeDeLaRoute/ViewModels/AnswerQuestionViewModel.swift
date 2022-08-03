//
//  AnswerQuestionViewModel.swift
//  CodeDeLaRoute
//
//  Created by HongTuan on 19/07/2022.
//

import Foundation
import SwiftUI

enum StatusQuestion{
    case learing, reviewing, correct, inCorrect, newQuestion
}

class AnswerQuestionViewModel: ObservableObject{
    @Published var inCorrectAnswer: String = ""
    @Published var isShowInCorrectAnswer: Bool = false
    @Published var showCorrectAnswer: Bool = false
    @Published var showExplanation: Bool = false
    @Published var selectedId: String?
    
    
    func changeQuestion(){
        withAnimation{
            showCorrectAnswer = false
            inCorrectAnswer = ""
            showExplanation = false
            selectedId = nil
        }
    }
    
    func getStatusQuestion(questionProgressApp: QuestionProgressApp) ->StatusQuestion{
        if questionProgressApp.progress.isEmpty{
            return .newQuestion
        }else{
            if questionProgressApp.progress.last == 0{
                return .learing
            }else{
                return .reviewing
            }
        }
    }
}
