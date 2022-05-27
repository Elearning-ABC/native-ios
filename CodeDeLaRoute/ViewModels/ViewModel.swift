//
//  ViewModel.swift
//  CodeDeLaRoute
//
//  Created by Nhung Nguyen on 27/04/2022.
//

import Foundation

class ViewModel: ObservableObject{
    @Published var testViewModel: TestViewModel
    init(testViewModel: TestViewModel = TestViewModel()){
        self.testViewModel = testViewModel
    }
    
    
    func test()->TestViewModel{
        return TestViewModel()
    }
}
