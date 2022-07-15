//
//  PracticeEndView.swift
//  CodeDeLaRoute
//
//  Created by HongTuan on 23/06/2022.
//

import SwiftUI

struct TestEndView: View {
    @EnvironmentObject var testViewModel : TestViewModel
    @StateObject var testEndViewModel = TestEndViewModel()
    var testProgressApp: TestProgressApp
    var testInfo: TestInfo
    var testLevel: TestLevel
    var title: String
    var practicEndNotUEnough = PracticeEnd(lable: "Not enough to pass :(", text: "Yowch! That hurt. Failing an exam always does. But hey, that was just one try. Get your notes together and try again. You can do it!", image: "SuccessImage1")
    var practicEndEnough = PracticeEnd(lable: "Such an excellent performance!", text: "Good job! You've successfully passed your test. Let's ace all the tests available to increase your passing possibility!", image: "SuccessImage1")
    
    func review(){
        
    }
    
    func tryAgain(){
        testViewModel.tryAgain(testInfo: testInfo, testLevel: testLevel)
    }
    
    
    var body: some View {
        let progress = Double(testProgressApp.correctQuestion)
        let total = Double(testInfo.totalQuestion)
        let practiceEnd = Int((progress/total)*100) >= testInfo.percentPassed ? practicEndEnough : practicEndNotUEnough
        VStack {
            HStack {
                BackHearderLeftView(title: title)
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
                    
                    let correct = testEndViewModel.getCorectNumberInTopic(testDataItem: testDataItem, testProgressApp: testProgressApp)
                    
                    let name = testEndViewModel.getNameInTopic(topicId: testDataItem.topicId)
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
    }
}

struct PracticeEndView_Previews: PreviewProvider {
    static var previews: some View {
        TestEndView(testProgressApp: TestProgressApp(testProgress: TestProgress()), testInfo: TestInfo(), testLevel: .easy, title: "")
    }
}

struct PracticeEnd{
    var lable: String
    var text: String
    var image: String
}
