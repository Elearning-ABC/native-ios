//
//  ReviewViewModel.swift
//  CodeDeLaRoute
//
//  Created by Nhung Nguyen on 03/06/2022.
//

import Foundation

class ReviewViewModel: ObservableObject{
    private var realmService: RealmService
    @Published var allFamiliarQuestion = [QuestionProgressApp]()
    @Published var weakQuestion = [QuestionProgressApp]()
    @Published var mediumQuestion = [QuestionProgressApp]()
    @Published var strongQuestion = [QuestionProgressApp]()
    @Published var favoriteQuestion = [QuestionProgressApp]()
    
    init(realmService: RealmService = RealmService()){
        self.realmService = realmService
        getAllQuestion()
    }
    
    func getAllQuestion(){
        let allQuestion = realmService.realmQuestionProgress.getAll()
        
        var allFamiliarQuestion = [QuestionProgressApp]()
        var weakQuestion = [QuestionProgressApp]()
        var mediumQuestion = [QuestionProgressApp]()
        var strongQuestion = [QuestionProgressApp]()
        var favoriteQuestion = [QuestionProgressApp]()
        
        for question in allQuestion{
            
            if !question.progress.isEmpty{
                
                allFamiliarQuestion.append(question)
                
                let average = averageProgress(progress: question.progress)
                
                if average >= 0.8{
                    strongQuestion.append(question)
                }
                if average >= 0.5 && average < 0.8{
                    mediumQuestion.append(question)
                }else{
                    weakQuestion.append(question)
                }
            }
            
            if question.bookmark == true {
                favoriteQuestion.append(question)
            }
        }
        print("all:",allQuestion)
        self.allFamiliarQuestion = allFamiliarQuestion
        self.weakQuestion = weakQuestion
        self.mediumQuestion = mediumQuestion
        self.strongQuestion = strongQuestion
        self.favoriteQuestion = favoriteQuestion
    }
    
    func averageProgress(progress: [Int])-> Double{
        var total = 0
        let length = progress.count
        for i in progress{
            total += i
        }
        let average = Double(total/length)
        return average
    }
}
