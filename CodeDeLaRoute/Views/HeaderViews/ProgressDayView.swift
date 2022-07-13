//
//  ProgressDayView.swift
//  CodeDeLaRoute
//
//  Created by Nhung Nguyen on 26/05/2022.
//

import SwiftUI
func test()->String{
    let date = Date()
    let calendar = Calendar.current
    let components = calendar.dateComponents([.weekday], from: date)
    let dayOfWeek = components.weekday
    return "\(dayOfWeek!)"
}


struct ProgressDayView: View {
    let week : [String] = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    let weekday = Date().daysOfWeek(using: .current)
    var body: some View {
        VStack {
            HStack(alignment: .center, spacing: 0) {
                Spacer()
                ForEach(weekday,id: \.self){ day in
                    if day.formatDate(formatter: "d") == Date().formatDate(formatter: "d"){
                        VStack{
                            Text(day.formatDate(formatter: "E"))
                                .foregroundColor(.blue1)
                                .font(.system(size: 12,weight: .semibold))
                            
                            ProgressCircleView(progress: 11, total: 20, width: 2, content: AnyView(Text(day.formatDate(formatter: "d")).font(.system(size: 12))))
                                .frame(width: 30, height: 30)
                           
                        }
                        .padding(.horizontal, 8.0)
                        .padding(.vertical)
                        .overlay(RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.blue2!, lineWidth: 1)
                        )

                    }else{
                        VStack{
                            Text(day.formatDate(formatter: "E"))
                                .foregroundColor(.gray)
                                .font(.system(size: 12, weight: .semibold))
                            
                            ProgressCircleView(progress: 11, total: 20, width: 2, content: AnyView(Text(day.formatDate(formatter: "d")).font(.system(size: 12))))
                                .frame(width: 30, height: 30)
                           
                        }
                    }
                    
                    Spacer()
                }
                
            }
        }
    }
}

struct ProgressDayView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressDayView()
    }
}
