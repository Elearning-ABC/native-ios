//
//  ViewModel.swift
//  CodeDeLaRoute
//
//  Created by Nhung Nguyen on 27/04/2022.
//

import Foundation
import SwiftUI

class ViewModel: ObservableObject{
    let realmSetting = RealmManager<Setting>(fileURL: .local)
    @Published var settingApp: SettingApp?
    @Published var showChangeFontSize = false
    @Published var imageString : String = ""
    let namespace: Namespace.ID
    @Published var showImage: Bool = false
    @Published var imageId : String = ""
    
    init(namespace: Namespace.ID){
        self.namespace = namespace
        getSettingApp()
    }
    
    func getSettingApp(){
        let realmSetting = RealmManager<Setting>(fileURL: .local)
        let settings =  realmSetting.queryAll()
        if !settings.isEmpty{
            print("debug: setting app")
            settingApp = SettingApp(setting: settings[0])
        }
    }
    
    func setSetting(){
        
        let setting = Setting(value: ["id": "\(UUID())", "fontSize": 16])
        let result = realmSetting.save(entity: setting)
        if result{
            settingApp = SettingApp(setting: setting)
        }
    }
    
    func onChangeFontSize(size: Double){
        settingApp?.fontSize = size
        let setting = Setting()
        setting.setValue(settingApp: settingApp!)
        _ = realmSetting.update(entity: setting)
    }
}
