//
//  TabViewModel.swift
//  CodeDeLaRoute
//
//  Created by Nhung Nguyen on 15/04/2022.
//

import Foundation
import SwiftUI

class TabViewModel: ObservableObject{
    
    
    struct TabItemData: Hashable {
        let image: String
        let active: Tabs
        let title: String
    }
    @Published var TabData: [TabItemData]
    
    @Published var active: Tabs = .tab1
    
    init(){
        let tab1 = TabItemData(image: "Book", active: .tab1, title: "Practice")
        let tab2 = TabItemData(image: "Document.icon", active: .tab2, title: "Test")
        let tab3 = TabItemData(image: "Eye.icon", active: .tab3, title: "Review")
        
        self.TabData = [tab1, tab2, tab3]
    }
    
    func switchTab(tab: Tabs){
        self.active = tab
    }
    
    
}


