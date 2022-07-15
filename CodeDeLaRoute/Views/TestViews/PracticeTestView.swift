//
//  PracticeTestView.swift
//  CodeDeLaRoute
//
//  Created by HongTuan on 30/06/2022.
//

import SwiftUI

struct PracticeTestView: View {
    @StateObject var practiceTestViewModel = PracticeTestViewModel()
    @EnvironmentObject var testViewModel: TestViewModel
    @State var title: String
    @State var counter : Int = 0
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var testInfo: TestInfo
    var testLevel: TestLevel

    init(testInfo: TestInfo, testLevel: TestLevel){
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
    
    func fetchData(){
        testViewModel.createTest(testInfo: testInfo, testLevel: testLevel)
    }
    func chekCorrect(answer: Answer){
        testViewModel.checkCorrect(answer: answer)
    }
    
    func checkInCorrect(answer: Answer){
        testViewModel.checkInCorrect(answer: answer)
    }
    
    func onRight(){
        practiceTestViewModel.isShowBody = false
        withAnimation{
            testViewModel.nextQuestion()
            practiceTestViewModel.isShowBody.toggle()
        }
        
    }
    
    func onHeart(questionId : String){
        practiceTestViewModel.bookmark.toggle()
        practiceTestViewModel.onHeart(questionId: questionId, testDataItems: convertListToArray(list: testInfo.testQuestionData))
    }
    
    func actionTimeEnd(){
        if testLevel == .hardest{
            onRight()
        }
    }
    
    func onSubmitTest(){
        practiceTestViewModel.isShowSubmitTest .toggle()
    }
    
    var body: some View {
        VStack{
            if let indexTestProgressApp = testViewModel.indexTestProgressApp{
                let testProgressApp = testViewModel.testProgressApps[indexTestProgressApp]
                VStack {
                    
                    if testProgressApp.status == 1{
                        
                        TestEndView(testProgressApp: testProgressApp, testInfo: testInfo, testLevel: testLevel, title: title)
                        
                    }else{
                        if let index = testViewModel.indexQuestion{
                            let question = testViewModel.questions[index]
                            let answers = testViewModel.getAnswers(questionId: question.id)
                            HeaderAnswerQuestionView(title: title,
                                                     correctNumber: index,
                                                     totalQuestion: testInfo.totalQuestion,
                                                     isTest: true,
                                                     isProgress: true,
                                                     onSubmit: {onSubmitTest()})
                            
                            if testLevel != .easy{
                                let time = practiceTestViewModel.getTime(testProgressApp: testProgressApp)
                                TimerTestView(time: time,
                                              duration: testInfo.duration,
                                              testLevel: testLevel,
                                              totalQuestion: testInfo.totalQuestion,
                                              index: index,
                                              actionTimeEnd: actionTimeEnd)
                                
                            }
                            if practiceTestViewModel.isShowBody{
                                VStack{
                                    QuestionBoxView(question: question.text, iconName: "")
                                    AnswerView(testLevel: testLevel,
                                               answers: answers,
                                               explanation: question.explanation ,
                                               checkCorrect: {answer in chekCorrect(answer: answer)},
                                               checkInCorrect: {answer in checkInCorrect(answer: answer)})
                                }
                                .padding()
                                .transition(.move(edge: .trailing))
                            }
                            
                            Spacer()
                            
                            FooterAnswerQuestionView(bookmark: practiceTestViewModel.bookmark, showPopup: $practiceTestViewModel.showReport, onRight: onRight, onHeart: {
                                onHeart(questionId: question.id)
                            })
                            .onAppear{
                                practiceTestViewModel.bookmark = practiceTestViewModel.getBookMark(questionId: question.id)
                            }
                            .onChange(of: question.id, perform: { questionId in
                                practiceTestViewModel.bookmark = practiceTestViewModel.getBookMark(questionId: questionId)
                            })
                        }
                    }
                }
                .popupView(isShow: $practiceTestViewModel.isShowSubmitTest, view: AnyView(SubmitTestView(isShowSubmitTest: $practiceTestViewModel.isShowSubmitTest, testInfo: testInfo, answered: testProgressApp.answeredQuestions.count, total: testProgressApp.totalQuestion)))
            }
        }
        .onAppear{
            fetchData()
        }
        .onDisappear{
            testViewModel.onDisAppear(time: counter)
        }
        .onReceive(timer) { time in
            if counter >= 0 {
                counter += 1
            }
        }
        .background(BackGroundView())
        .ignoresSafeArea()
    }
}

//struct PracticeTestView_Previews: PreviewProvider {
//    static var previews: some View {
//        TimerTestView(counter: 60)
//    }
//}


struct SubmitTestView: View{
    @EnvironmentObject var testViewModel: TestViewModel
    @Binding var isShowSubmitTest: Bool
    var testInfo: TestInfo
    var answered: Int
    var total: Int
    var body: some View{
        VStack{
            Text("SUBMIT TEST?")
                .font(.title2)
                .padding(.bottom)
            
            Text("You answered \(answered) of \(total) question on")
                .foregroundColor(.gray)
            Text("this test")
                .foregroundColor(.gray)
            
            HStack(spacing: 8){
                HStack{
                    Spacer()
                    Text("Continue")
                        .font(.title2)
                        .padding(.vertical, 4.0)
                    Spacer()
                }
                .overlay(RoundedRectangle(cornerRadius: 12)
                    .stroke(.gray, lineWidth: 1))
                .cornerRadius(12)
                .onTapGesture {
                    isShowSubmitTest = false
                }
                
                HStack{
                    Spacer()
                    Text("Submit")
                        .padding(.vertical, 4.0)
                    
                    Spacer()
                }
                .foregroundColor(.white)
                .font(.title2)
                .background(Color.blue1)
                .cornerRadius(12)
                .onTapGesture {
                    testViewModel.submitTest(testInfo: testInfo)
                    isShowSubmitTest = false
                }
            }
        }
        .padding()
        .background(.white)
        .cornerRadius(12)
        .padding()
    }
}
