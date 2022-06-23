//
//  Extension.swift
//  CodeDeLaRoute
//
//  Created by Nhung Nguyen on 28/04/2022.
//

import Foundation
import UIKit

extension String {

    func replace(target: String, withString: String) -> String {
        return self.replacingOccurrences(of: target, with: withString)
    }
    
}
