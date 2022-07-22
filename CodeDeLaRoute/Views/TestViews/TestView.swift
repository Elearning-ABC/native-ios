//
//  TestView.swift
//  CodeDeLaRoute
//
//  Created by Nhung Nguyen on 14/04/2022.
//

import SwiftUI

struct TestView: View {
    @EnvironmentObject var viewModel : ViewModel
    @StateObject var testViewModel = TestViewModel()

    @State var isShowToast: Bool = false
    var body: some View {
        ScrollView{
            ForEach(testViewModel.testInfos){testInfo in
                let title = testInfo.title + " \(testInfo.index + 1)"
                PracticeTestRowView(isShowToast: $isShowToast, testInfo: testInfo, title: title, totalQuestion: testInfo.totalQuestion)
                    .environmentObject(testViewModel)
            }
        }
        .padding()
        .toast(message: "Completed previous test!", isShowing: $isShowToast, config: .init(textColor: .orange, backgroundColor: Color.orange1!,duration: Toast.short),alertType: .warning)
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            Color.gray.ignoresSafeArea()
        }
    }
}

struct PracticeTestRowView: View{
    @EnvironmentObject var testViewModel : TestViewModel
    @Binding var isShowToast: Bool
    @State var testProgressApp: TestProgressApp?
    @State var testLevel : TestSetting?
    var testInfo: TestInfo
    var title: String
    var totalQuestion: Int
    
    func getCurrentTest(testProgressApp: TestProgressApp)->TestSetting?{
        if testProgressApp.status == 1 || testProgressApp.time == 0{
            return nil
        }else{
            switch testProgressApp.testSetting{
            case 1:
                return .easy
            case 2:
                return .medium
            case 3:
                return .hardest
            default:
                return nil
            }
        }
    }
    
    func onAppear(){
        testProgressApp = testViewModel.getTestProgressApp(testInfoId: testInfo.id)
        testLevel = getCurrentTest(testProgressApp: testProgressApp!)
    }
    
    var body: some View {
        VStack{
            if let testProgressApp = testProgressApp {
                let lock = testProgressApp.lock
                let percentPass = testInfo.percentPassed
                if lock{
                    NavigationLink(destination: DetailTestView(testInfo: testInfo, testLevel: testLevel )
                        .environmentObject(testViewModel)
                        .navigationBarHidden(true), label: {
                            TestRowView(title: title, testProgressApp: testProgressApp, persentPass: percentPass)
                        })
                    .padding(.bottom, 14.0)
                }else{
                    TestRowView(title: title, testProgressApp: testProgressApp, persentPass: percentPass )
                        .padding(.bottom, 14.0)
                        .onTapGesture {
                            isShowToast = true
                        }
                }
            }
        }
        .onAppear(perform: onAppear)
    }
}

struct TestRowView: View{
    var title: String
    var testProgressApp: TestProgressApp
    var persentPass: Int
    
    var body: some View{
        let lock = testProgressApp.lock
        let value = CGFloat(testProgressApp.correctQuestion)
        let total = CGFloat(testProgressApp.totalQuestion)
        let percent = Int(value*100/total)
        VStack{
            HStack {
                Text(title)
                    .foregroundColor(.blue1)
                    .font(.system(size: 24, weight: .semibold))
                Spacer()
                if testProgressApp.status == 1{
                    if percent >= persentPass{
                        
                    }else{
                        Image(systemName: "xmark")
                            .foregroundColor(.red)
                    }
                }else{
                    if !lock{
                        Image("lock")
                    }
                }
            }
            DividingLineView()
            HStack{
                ProgressView(value: value, total: total)
                    .accentColor(Color.blue1)
                    .background(Color.blue3)
                    .frame(height: 8.0)
                    .scaleEffect(x: 1, y: 2, anchor: .center)
                    .clipShape(RoundedRectangle(cornerRadius: 4))
                
                Text("\(percent)%")
                    .foregroundColor(.black)
                    .font(.system(size: 14))
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(8)
    }
}
