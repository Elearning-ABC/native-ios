//
//  FooterQuestionView.swift
//  CodeDeLaRoute
//
//  Created by Nhung Nguyen on 28/04/2022.
//

import SwiftUI

struct FooterQuestionView: View {
    @Binding var selection : Int
    var body: some View {
        HStack {
            
            VStack{
                Image(systemName: "flag")
                    .foregroundColor(.blue3)
                    .font(.system(size: 20, weight: .bold))
            }
            .frame(width: 60, height: 30)
            
            Spacer()
            VStack{
                Image(systemName: "heart")
                    .foregroundColor(.blue3)
                    .font(.system(size: 20))
            }
            .frame(width: 60, height: 30)
            
            Spacer()
            
            VStack{
                Image(systemName: "chevron.right")
                    .foregroundColor(.blue1)
                    .font(.system(size: 20))
            }
            .frame(width: 60, height: 30)
            .onTapGesture {
                selection += 1
            }
            
            
        }
        .padding(.horizontal, 30.0)
        .padding(.vertical, 30.0)
        .background(Color.white)
    }
}

struct FooterQuestionView_Previews: PreviewProvider {
    static var previews: some View {
        FooterQuestionView(selection: .constant(0))
    }
}
