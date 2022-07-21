//
//  AnswerQuestionViewModel.swift
//  CodeDeLaRoute
//
//  Created by HongTuan on 19/07/2022.
//

import Foundation
import SwiftUI

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
}
