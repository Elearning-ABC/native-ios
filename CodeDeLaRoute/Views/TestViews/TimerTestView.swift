//
//  TimerTestView.swift
//  CodeDeLaRoute
//
//  Created by HongTuan on 01/07/2022.
//

import SwiftUI

struct TimerTestView: View{
    @State var counter: Int
    @State var time: Time
    var index: Int
    var duration: Int
    var total: Int
    var testLevel: TestSetting
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var actionTimeEnd : () -> Void
    
    func restTime(){
        let timeStart = duration/total
        time.update(time: timeStart)
        self.counter = timeStart
    }
    
    
    init(time: Int, duration: Int ,testLevel: TestSetting, totalQuestion: Int, index: Int,actionTimeEnd : @escaping () -> Void){
        var timeStart = 0
        if testLevel == .medium{
            timeStart = duration - time
        }else{
            timeStart = duration/totalQuestion
        }
        self.counter = timeStart
        self.time = Time(time: timeStart)
        self.actionTimeEnd = actionTimeEnd
        self.duration = duration
        self.total = totalQuestion
        self.testLevel = testLevel
        self.index = index
    }
    
    
    
    var body: some View{
        VStack{
            HStack(alignment: .center, spacing: 0){
                Image("clock")
                    .padding(.trailing, 5.0)
                Text("\(time.hours < 10 ? "0" : "")\(time.hours)")
                    .font(.system(size: 18, weight: .semibold))
                    .frame(width: 25)
                Text(":")
                    .font(.system(size: 18, weight: .semibold))
                if let minutes = time.minutes {
                    Text("\(minutes < 10 ? "0" : "")\(minutes)")
                        .font(.system(size: 18, weight: .semibold))
                        .frame(width: 25)
                }
                Text(":")
                    .font(.system(size: 18, weight: .semibold))
                if let seconds = time.seconds {
                    Text("\(seconds < 10 ? "0" : "")\(seconds)")
                        .font(.system(size: 18, weight: .semibold))
                        .frame(width: 25)
                }
            }
        }
        .onReceive(timer) { time in
            if counter > 0 {
                counter -= 1
                self.time.update(time: counter)
            }
            
            if counter == 0{
                actionTimeEnd()
                if testLevel == .hardest{
                    restTime()
                }
                
            }
        }
        .onChange(of: index, perform: {_ in
            if testLevel == .hardest{
                restTime()
            }
        })
    }
}

struct Time{
    var hours: Int
    var seconds: Int
    var minutes: Int
    
    init(time: Int){
        let hours = time / (60*60)
        let minutes = Int((time - hours*60*60) / 60)
        let seconds = time % 60
        self.hours = hours
        self.seconds = seconds
        self.minutes = minutes
    }
    
    mutating func update(time: Int){
        let hours = time / (60*60)
        let minutes = Int((time - hours*60*60) / 60)
        let seconds = time % 60
        self.hours = hours
        self.seconds = seconds
        self.minutes = minutes
    }
}

//struct TimerTestView_Previews: PreviewProvider {
//    static var previews: some View {
//        TimerTestView(time: 1, duration: 20, testLevel: .medium, totalQuestion: 0, actionTimeEnd: {})
//    }
//}

