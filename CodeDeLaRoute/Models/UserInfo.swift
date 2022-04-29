//
//  UserInfo.swift
//  CodeDeLaRoute
//
//  Created by Nhung Nguyen on 26/04/2022.
//

import Foundation
import RealmSwift

class UserInfo: Object{
    @Persisted(primaryKey: true) var id: String
    @Persisted var email: String
}
