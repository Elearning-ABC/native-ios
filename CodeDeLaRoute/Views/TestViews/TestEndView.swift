//
//  PracticeEndView.swift
//  CodeDeLaRoute
//
//  Created by HongTuan on 23/06/2022.
//

import SwiftUI

struct TestEndView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @EnvironmentObject var testViewModel : TestViewModel
    @EnvironmentObject var practiceTestViewModel: PracticeTestViewModel
    @State var isShowReview: Bool = false
    @Binding var counter: Int
    var testProgressApp: TestProgressApp
    @Binding var testInfo: TestInfo
    var testLevel: TestSetting
    @State var title: String = ""
    
    var practicEndNotUEnough = PracticeEnd(lable: "Not enough to pass :(", text: "Yowch! That hurt. Failing an exam always does. But hey, that was just one try. Get your notes together and try again. You can do it!", image: "SuccessImage1")
    var practicEndEnough = PracticeEnd(lable: "Such an excellent performance!", text: "Good job! You've successfully passed your test. Let's ace all the tests available to increase your passing possibility!", image: "SuccessImage1")
    
    func onAppear(){
        title = testInfo.title + " \(testInfo.index + 1)"
    }
    
    func review(){
        isShowReview.toggle()
    }
    
    func tryAgain(){
        counter = 0
        testViewModel.tryAgain(testInfoId: testInfo.id, testLevel: testLevel)
    }
    
    func continueTest(){
        if let testInfo = practiceTestViewModel.getNextTestInfo(testInfos: testViewModel.testInfos, index: testInfo.index){
            self.testInfo = testInfo
            actionBack()
        }
    }
    
    func actionBack(){
        if testViewModel.isDetailTest{
            withAnimation{
                testViewModel.isDetailTest.toggle()
            }
        }else{
            mode.wrappedValue.dismiss()
        }
    }
    
    var body: some View {
        let progress = Double(testProgressApp.correctQuestion)
        let total = Double(testInfo.totalQuestion)
        let practiceEnd = Int((progress/total)*100) >= testInfo.percentPassed ? practicEndEnough : practicEndNotUEnough
        VStack {
            HStack {
                BackHearderLeftView(title: title, isBack: testViewModel.isDetailTest ? false : true, action: actionBack)
                Spacer()
            }
            .padding(.horizontal, 24.0)
            .padding(.top, Screen.statusBarHeight)
            
            VStack{
                ProgressHalfCircleView(progress: progress, total: total)
            }
            .frame(width: Screen.width/2, height: Screen.width/2, alignment: .center)
            .padding(.bottom, -Screen.width/4+40)
            
            HStack {
                VStack {
                    Text(practiceEnd.lable)
                        .foregroundColor(.blue1)
                        .font(.system(size: 24, weight: .bold))
                        .padding(.bottom)
                    Text(practiceEnd.text)
                        .font(.system(size: 16))
                }
                Image(practiceEnd.image)
            }
            .padding()
            
            ScrollView{
                ForEach(testInfo.testQuestionData){ testDataItem in
                    
                    let correct = practiceTestViewModel.getCorectNumberInTopic(testDataItem: testDataItem, testProgressApp: testProgressApp)
                    
                    let name = practiceTestViewModel.getNameInTopic(topicId: testDataItem.topicId)
                    ReviewTopicRowView(name: name, value: correct, total: Double(testDataItem.questionNum))
                }
            }
            .padding(.horizontal)
            VStack{
                HStack{
                    Button(action: {
                        review()
                    }, label: {
                        HStack{
                            Spacer()
                            Text("Review")
                                .foregroundColor(.black)
                                .font(.system(size: 16, weight: .bold))
                            Spacer()
                        }
                        .padding()
                        .background(Color.blue3)
                        .cornerRadius(12)
                    })
                    Button(action: {
                        tryAgain()
                    }, label: {
                        HStack{
                            Spacer()
                            Text("Try Again")
                                .foregroundColor(.white)
                                .font(.system(size: 16, weight: .bold))
                            Spacer()
                        }
                        .padding()
                        .background(Color.red)
                        .cornerRadius(12)
                    })
                }
                Button(action: {
                    continueTest()
                }, label: {
                    HStack{
                        Spacer()
                        Text("Continue")
                            .foregroundColor(.white)
                            .font(.system(size: 16, weight: .bold))
                        Spacer()
                    }
                    .padding()
                    .background(Color.blue1)
                    .cornerRadius(12)
                })
                
            }
            .padding([.leading, .bottom, .trailing])
        }
        .background(BackGroundView())
        .onAppear(perform: onAppear)
        .popupView(isShow: $isShowReview, view: AnyView(ReviewEndTestView(isShowReView: $isShowReview, testInfo: testInfo, answeredQuestionApps: testProgressApp.answeredQuestionApps)))
    }
}

struct PracticeEndView_Previews: PreviewProvider {
    static var previews: some View {
        TestEndView(counter: .constant(1), testProgressApp: TestProgressApp(testProgress: TestProgress()), testInfo: .constant(TestInfo()), testLevel: .easy, title: "")
    }
}

struct PracticeEnd{
    var lable: String
    var text: String
    var image: String
}


struct ReviewEndTestView: View{
    @EnvironmentObject var testViewModel : TestViewModel
    @EnvironmentObject var practiceTestViewModel: PracticeTestViewModel
    @Binding var isShowReView: Bool
    var testInfo: TestInfo
    var answeredQuestionApps: [AnsweredQuestionApp]
    
    @State var size: Int = 10
    
    func loadMore() {
            print("Load more...")
            size += 10
        }
    
    var body: some View{
        VStack {
            HStack{
                Text("Review")
                    .bold()
                    .font(.title3)
                Spacer()
                Image(systemName: "xmark")
                    .font(.title3)
                    .onTapGesture {
                        isShowReView.toggle()
                    }
            }
            .padding([.top, .leading, .trailing])
            
            ScrollView(showsIndicators: false){
                LazyVStack(spacing: 8){
                    ForEach(answeredQuestionApps.indices, id: \.self){ i in
                        let answeredQuestionApp = answeredQuestionApps[i]
                        let question = testViewModel.getQuestion(questionId: answeredQuestionApp.questionId)
                        let bookmark = practiceTestViewModel.getBookMark(questionId: answeredQuestionApp.questionId)
                        let progress: [Int] = practiceTestViewModel.getProgress(selectedIds: answeredQuestionApp.selectedIds)
                        var answers = testViewModel.getAnswers(questionId: question.id)
                        
                        let inCorrectAnswerId = answeredQuestionApps[i].selectedIds.isEmpty ? "" : answeredQuestionApps[i].selectedIds[0]
                        
                        QuestionReviewRowView(question: question, answers: answers, progress: progress, bookmark: bookmark,index: i + 1,inCorrectAnswerId: inCorrectAnswerId, showAnswer: true, onHeart: {
                            practiceTestViewModel.onHeart(questionId: answeredQuestionApp.questionId, testDataItems: convertListToArray(list: testInfo.testQuestionData))
                        })
                    }
                }
                .padding(.horizontal, 16.0)
            }
        }
        .background(Color.blue4)
        .frame(height: Screen.height - 160)
        .cornerRadius(12)
    }
}
