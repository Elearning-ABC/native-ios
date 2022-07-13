//
//  FooterAnswerQuestionView.swift
//  CodeDeLaRoute
//
//  Created by HongTuan on 30/06/2022.
//

import SwiftUI

struct FooterAnswerQuestionView: View {
    var bookmark: Bool
    @Binding var showPopup : Bool
    
    var onRight: () -> Void
    var onHeart: () -> Void
    
    var body: some View {
        HStack {
            HStack{
                Spacer()
                Image(systemName: "flag")
                    .foregroundColor(.blue3)
                    .font(.system(size: 20, weight: .bold))
                Spacer()
            }
            .background(.white)
            .onTapGesture {
                showPopup.toggle()
            }
            
            HStack{
                Spacer()
                if bookmark
                {
                    Image(systemName: "heart.fill")
                        .foregroundColor(.blue1)
                        .font(.system(size: 20))
                }else{
                    Image(systemName: "heart")
                        .foregroundColor(.blue3)
                        .font(.system(size: 20))
                }
                Spacer()
            }
            .background(.white)
            .onTapGesture {
                onHeart()
            }
            
            HStack{
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.blue1)
                    .font(.system(size: 20))
                Spacer()
            }
            .background(.white)
            .onTapGesture {
                onRight()
            }
        }
        .padding(.horizontal, 30.0)
        .padding(.bottom, 40.0)
        .padding(.top, 15.0)
        .background(Color.white)
    }
}

//struct FooterAnswerQuestionView_Previews: PreviewProvider {
//    static var previews: some View {
//        FooterAnswerQuestionView()
//    }
//}
