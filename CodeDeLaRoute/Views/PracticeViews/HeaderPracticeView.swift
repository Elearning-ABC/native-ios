//
//  HeaderPracticeView.swift
//  CodeDeLaRoute
//
//  Created by Nhung Nguyen on 19/04/2022.
//

import SwiftUI

struct HeaderPracticeView: View {
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "text.justify")
                    .font(.system(size: 24))
                
                ZStack {
                    HStack{
                        Spacer()
                        Text("GET PRO")
                            .foregroundColor(.white)
                            .font(.system(size: 16, weight: .bold))
                        Spacer()
                    }
                    .frame(height: 40)
                    .background(Image("background.getpro").resizable())
                    
                    HStack {
                        Image("crown")
                        Spacer()
                    }.padding(.leading)
                }
                .padding(.horizontal)
                
                Image("avatar")
            }
            DividingLineView(color: Color.blue3!)
            
            HStack(alignment: .top){
                Image("cup.tick")
                VStack(alignment: .leading){
                    Text("Complete your today plan to get a 91% passing rate ")
                        .foregroundColor(.blue1)
                        .font(.system(size: 16))
                    Text("Today plan: 6/20")
                        .foregroundColor(.blue2)
                        .font(.system(size: 18))
                    ProgressView(value: 6, total: 20)
                        .accentColor(Color.blue2)
                    
                    
                    HStack {
                        Spacer()
                        Image(systemName: "chevron.right.2")
                            .rotationEffect(Angle(degrees: 90.0))
                        Spacer()
                    }
                    .padding([.top, .leading, .trailing])
                }
                VStack{
                    Text("Wed")
                        .foregroundColor(.blue2)
                        .font(.system(size: 12,weight: .heavy))
                    ProgressCircleView(progress: 11, total: 20, width: 2)
                        .frame(width: 30, height: 30)
                   
                }
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.blue, lineWidth: 1)
                        )
            }
            
            
        }
        .padding(.top, Screen.statusBarHeight)
        .padding([.leading, .bottom, .trailing])	
        .background(Color.white)
        .cornerRadius(25, corners: [.bottomLeft, .bottomRight])
        

    }
}

struct HeaderPracticeView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderPracticeView()
    }
}

