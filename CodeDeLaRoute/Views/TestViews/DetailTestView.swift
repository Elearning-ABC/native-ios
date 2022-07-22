//
//  DetailTestView.swift
//  CodeDeLaRoute
//
//  Created by HongTuan on 29/06/2022.
//

import SwiftUI

struct DetailTestView: View {
    @EnvironmentObject var testViewModel: TestViewModel
    @State var title: String = ""
    @State var testInfo: TestInfo
    var testLevel: TestSetting?
    
    func onAppear(){
        title = testInfo.title + " \(testInfo.index + 1)"
        if testLevel != nil{
            testViewModel.isDetailTest = true
        }else{
            testViewModel.isDetailTest = false
        }
    }
    var body: some View {
        VStack{
            if testViewModel.isDetailTest{
                if let testLevel = testLevel {
                    PracticeTestView(testInfo: $testInfo, testLevel: testLevel)
                        .environmentObject(testViewModel)
                        .navigationBarHidden(true)
                        .transition(.move(edge: .trailing))
                }
            }else{
                VStack {
                    HStack {
                        BackHearderLeftView(title: title)
                        Spacer()
                    }
                    .padding()
                    .background(.white)
                    VStack{
                        HeaderDetailTestView(testInfo: testInfo)
                        
                        ScrollView{
                            ForEach(TestSetting.allCases, id : \.self){
                                testLevel in
                                NavigationLink(destination: PracticeTestView(testInfo: $testInfo, testLevel: testLevel)
                                    .environmentObject(testViewModel)
                                    .navigationBarHidden(true), label: {
                                        LevelRowView(testInfo: testInfo, testLevel: testLevel)
                                            .padding(.bottom, 8.0)
                                    })
                            }
                        }
                        .padding(.top, 24.0)
                        
                    }
                    .padding()
                    .background(BackGroundView())
                }
            }
        }
        .onAppear(perform: onAppear)
        .onChange(of: testViewModel.isDetailTest, perform: {_ in
            title = testInfo.title + " \(testInfo.index + 1)"
        })
    }
}

struct DetailTestView_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
        }
    }
}


struct HeaderDetailTestView: View{
    var testInfo: TestInfo
    var body: some View{
        let totalQuestion = testInfo.totalQuestion
        let percentPassed = testInfo.percentPassed
        let correctAnswer = totalQuestion*percentPassed/100
        let mistakeAllowed = totalQuestion - correctAnswer
        
        HStack{
            VStack{
                Text("Total")
                    .font(.system(size: 13))
                Text("question")
                    .font(.system(size: 13))
                Text(totalQuestion.toString())
                    .font(.system(size: 14, weight: .bold))
                    .padding(.top, 3.0)
            }
            Spacer()
            VStack{
                Text("Passing")
                    .font(.system(size: 13))
                Text("score")
                    .font(.system(size: 13))
                Text(percentPassed.toString()+"%")
                    .font(.system(size: 14, weight: .bold))
                    .padding(.top, 3.0)
            }
            Spacer()
            VStack{
                Text("Correct")
                    .font(.system(size: 13))
                Text("answer")
                    .font(.system(size: 13))
                ZStack(alignment: .topTrailing) {
                    Text(correctAnswer.toString())
                        .font(.system(size: 14, weight: .bold))
                        .padding(.top, 3.0)
                    Image(systemName: "checkmark")
                        .font(.system(size: 12))
                        .padding(.trailing, -12.0)
                }
            }
            Spacer()
            VStack{
                Text("Mistake")
                    .font(.system(size: 13))
                Text("allowed")
                    .font(.system(size: 13))
                ZStack(alignment: .topTrailing) {
                    Text(mistakeAllowed.toString())
                        .font(.system(size: 14, weight: .bold))
                        .padding(.top, 3.0)
                    Image(systemName: "xmark")
                        .font(.system(size: 12))
                        .padding(.trailing, -12.0)
                }
            }
        }
        .padding()
        .background(.white)
        .cornerRadius(8)
    }
}


struct LevelRowView: View{
    @EnvironmentObject var testViewModel: TestViewModel
    var title: String
    var testInfo: TestInfo
    var testLevel: TestSetting
    
    init(testInfo: TestInfo, testLevel: TestSetting){
        self.testInfo = testInfo
        self.testLevel = testLevel
        switch testLevel {
        case .easy:
            title = Constant.EASY
        case .medium:
            title = Constant.MEDIUM
        case .hardest:
            title = Constant.HARDEST
        }
    }
    
    @State var percent: Int?
    @State var progress: Double?
    
    var body: some View{
        let minute = Int(testInfo.duration/60)
        let seconds = Int(testInfo.duration/testInfo.totalQuestion)
        let testProgressApp = testViewModel.getTestProgressApp(testInfoId: testInfo.id, testLevel: testLevel)
        
        HStack{
            VStack(alignment: .leading, spacing: 10){
                Text(title)
                    .font(.system(size: 16, weight: .bold))
                
                switch testLevel {
                case .easy:
                    Text("Instant feedback")
                        .foregroundColor(.gray)
                        .font(.system(size: 16))
                case .medium:
                    Text("\(minute) minute test")
                        .foregroundColor(.gray)
                        .font(.system(size: 16))
                case .hardest:
                    Text("\(seconds) seconds / questions")
                        .foregroundColor(.gray)
                        .font(.system(size: 16))
                }
                
            }
            Spacer()
            if let testProgressApp = testProgressApp {
                if let progress = progress {
                    if testProgressApp.status == 1{
                        if Int(progress) < testInfo.percentPassed{
                            VStack{
                                Text("\(Int(progress)) / \(testInfo.totalQuestion)")
                                    .foregroundColor(.red)
                                    .font(.system(size: 12))
                                Text("Failed")
                                    .foregroundColor(.red)
                                    .font(.system(size: 12))
                            }
                        }else{
                            VStack{
                                Text("\(Int(progress)) / \(testInfo.totalQuestion)")
                                    .foregroundColor(Color.green)
                                    .font(.system(size: 12))
                                Text("Pass")
                                    .foregroundColor(Color.green)
                                    .font(.system(size: 12))
                            }
                        }
                    }else{
                        if testProgressApp.time == 0{
                            Image(systemName: "arrow.right")
                                .foregroundColor(.gray)
                                .frame(width: 35, height: 35, alignment: .center)
                        }else{
                            ProgressCircleView(progress: progress, total: Double(testInfo.totalQuestion), color: .blue, width: 3, content: AnyView(Text("\(percent!)%").font(.system(size: 12))))
                                .frame(width: 35, height: 35, alignment: .center)
                        }
                    }
                }
            }
            
        }
        .onAppear{
            progress = Double(testViewModel.getCorrectNumber(testInfoId: testInfo.id, testLevel: testLevel))
            percent = 100*Int(progress!) / testInfo.totalQuestion
        }
        .padding()
        .background(.white)
        .cornerRadius(8)
    }
}
