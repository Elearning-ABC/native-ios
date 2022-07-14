//
//  Array.swift
//  CodeDeLaRoute
//
//  Created by HongTuan on 28/06/2022.
//

import Foundation

extension Array where Element : QuestionProgressApp {
    
    func sortQuestionProgressApps() -> [QuestionProgressApp]{
        var questionProgressAppsArranged = self

        var checkNewQuestion : Bool = false
        var inCorrectNumber : Int = 0
        
        for questionProgressApp in questionProgressAppsArranged {
            if questionProgressApp.boxNum == 0{
                checkNewQuestion = true
            }
            if questionProgressApp.boxNum == -1{
                inCorrectNumber += 1
            }
        }
        
        if checkNewQuestion{
            var elements: [Element] = []
            var index = 0
            for i in questionProgressAppsArranged.indices {
                let element = questionProgressAppsArranged[i]
                if questionProgressAppsArranged[i].boxNum != 0 {
                    elements.append(element)
                }else{
                    elements.insert(element, at: index)
                    index += 1
                }
            }
            questionProgressAppsArranged = elements
            
        }else{
            questionProgressAppsArranged = questionProgressAppsArranged.sorted(by: {$0.boxNum < $1.boxNum})
            
            if inCorrectNumber == 1{
                if questionProgressAppsArranged[0].id == self[0].id{
                    let temp = questionProgressAppsArranged[0]
                    questionProgressAppsArranged.remove(at: 0)
                    questionProgressAppsArranged.shuffle()
                    questionProgressAppsArranged.append(temp)
                }
            }else{
                if questionProgressAppsArranged[0].id == self[0].id{
                    let temp = questionProgressAppsArranged[0]
                    questionProgressAppsArranged.remove(at: 0)
                    questionProgressAppsArranged.append(temp)
                }
            }
            
        }
        return questionProgressAppsArranged
    }
}
