//
//  Question.swift
//  CodeDeLaRoute
//
//  Created by Nhung Nguyen on 14/04/2022.
//

import Foundation
import RealmSwift

class Question: Object, ObjectKeyIdentifiable{
    @Persisted(primaryKey: true) var id: String
    @Persisted var parentId: String
    @Persisted var paragraphId: String
    @Persisted var status: Int
    @Persisted var text: String
    @Persisted var video: String
    @Persisted var audio: String
    @Persisted var image: String
    @Persisted var hint: String
    @Persisted var explanation: String
    @Persisted var hasChild: Bool
    @Persisted var level: Int
    @Persisted var createDate: Double
    @Persisted var lastUpdate: Double
    @Persisted var choices: List<Answer>
    @Persisted var correctAnswers: List<String>
    @Persisted var inCorrectAnswers: List<String>
    @Persisted var correctAnswerNumber: Int
}
