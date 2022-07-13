//
//  TestInfo.swift
//  CodeDeLaRoute
//
//  Created by HongTuan on 28/06/2022.
//

import Foundation
import RealmSwift

class TestInfo: Object, Identifiable{
    @Persisted(primaryKey: true) var id: String
    @Persisted var title: String
    @Persisted var index: Int
    @Persisted var type: Int
    @Persisted var lastUpdate: Double
    @Persisted var testQuestionData: List<TestDataItem>
    @Persisted var stateId: String
    @Persisted var topicId: String
    @Persisted var totalQuestion: Int
    @Persisted var duration: Int
    @Persisted var percentPassed: Int
}
