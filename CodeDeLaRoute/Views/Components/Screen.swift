//
//  Screen.swift
//  CodeDeLaRoute
//
//  Created by Nhung Nguyen on 21/04/2022.
//

import SwiftUI

struct Screen {
    static var width: CGFloat {  return UIScreen.main.bounds.width }
    static var height: CGFloat {  return UIScreen.main.bounds.height }
    static var statusBarHeight: CGFloat {
        let viewController = UIApplication.shared.windows.first!.rootViewController
        return viewController!.view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        
    }
}
