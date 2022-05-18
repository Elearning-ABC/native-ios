//
//  Process.swift
//  CodeDeLaRoute
//
//  Created by Nhung Nguyen on 11/05/2022.
//

import Foundation
import SwiftUI

struct Process{
    var correct: CGFloat
    var inCorrect: CGFloat
    var newQuestion: Int
    var total: CGFloat
    var indexTopic: Int
    var indexParentTopic: Int
    var indexListChildTopic: Int
    var title: String
    
    mutating func reset(){
        self.correct = 0
        self.inCorrect = 0
    }
}
