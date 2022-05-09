//
//  Answer.swift
//  CodeDeLaRoute
//
//  Created by Nhung Nguyen on 26/04/2022.
//

import Foundation
import RealmSwift

class Answer: Object, ObjectKeyIdentifiable{
    @Persisted(primaryKey: true) var id: String
    @Persisted var text: String
    @Persisted var questionId: String
    @Persisted var isCorrect: Bool
}
