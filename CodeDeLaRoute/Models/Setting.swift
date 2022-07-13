//
//  Setting.swift
//  CodeDeLaRoute
//
//  Created by HongTuan on 23/06/2022.
//

import Foundation
import RealmSwift
import SwiftUI

class Setting: Object{
    @Persisted(primaryKey: true) var id: String
    @Persisted var fontSize: Double
    
    func setValue(settingApp: SettingApp){
        id = settingApp.id
        fontSize = settingApp.fontSize
    }
}

struct SettingApp{
    var id: String
    var fontSize: CGFloat
    
    init(setting: Setting){
        id = setting.id
        fontSize = setting.fontSize
    }
}

