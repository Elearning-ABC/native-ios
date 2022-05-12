//
//  Status.swift
//  CodeDeLaRoute
//
//  Created by Nhung Nguyen on 11/05/2022.
//

import Foundation
import SwiftUI

struct Status{
    var status: String
    var color: Color
    var iconName: String
    var text: String
    
    mutating func upDate( status: String, color: Color, iconName: String, text: String){
        self.status = status
        self.color = color
        self.iconName = iconName
        self.text = text
    }
}
