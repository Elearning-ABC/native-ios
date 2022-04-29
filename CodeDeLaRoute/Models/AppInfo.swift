//
//  AppInfo.swift
//  CodeDeLaRoute
//
//  Created by Nhung Nguyen on 21/04/2022.
//

import Foundation
import RealmSwift

class AppInfo: Object, ObjectKeyIdentifiable{
    @Persisted(primaryKey: true) var id: String
    @Persisted var name: String
    @Persisted var title: String
    @Persisted var buildNumber: String
    @Persisted var packageName: String
    @Persisted var bucket: String
    @Persisted var website: String
    @Persisted var urlAndroid: String
    @Persisted var urlIos: String
    @Persisted var thumbnail: String
    @Persisted var version: String
    @Persisted var hasState: Bool
    @Persisted var lastUpdate: Double
}
