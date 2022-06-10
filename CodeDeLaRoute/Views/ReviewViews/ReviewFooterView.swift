//
//  ReviewFooterView.swift
//  CodeDeLaRoute
//
//  Created by Nhung Nguyen on 09/06/2022.
//

import SwiftUI

struct ReviewFooterView: View {
    @EnvironmentObject var viewModel : ReviewViewModel
    @Binding var showPopup : Bool
    
    var tabRight: () -> Void
    
    var body: some View {
        HStack {
            VStack{
                Image(systemName: "flag")
                    .foregroundColor(.blue3)
                    .font(.system(size: 20, weight: .bold))
            }
            .frame(width: 60, height: 30)
            .onTapGesture {
                showPopup.toggle()
            }
            
            Spacer()
            VStack{
                if viewModel.listQuestionProgress[0].bookmark
                {
                    Image(systemName: "heart.fill")
                        .foregroundColor(.blue1)
                        .font(.system(size: 20))
                }else{
                    Image(systemName: "heart")
                        .foregroundColor(.blue3)
                        .font(.system(size: 20))
                }
            }
            .frame(width: 60, height: 30)
            .onTapGesture {
//                viewModel.updateBookmark()
            }
            
            Spacer()
            
            VStack{
                Image(systemName: "chevron.right")
                    .foregroundColor(.blue1)
                    .font(.system(size: 20))
            }
            .frame(width: 60, height: 30)
            .onTapGesture {
                withAnimation(.easeIn){
                    tabRight()
                }
            }
            
            
        }
        .padding(.horizontal, 30.0)
        .padding(.bottom, 40.0)
        .padding(.top, 15.0)
        .background(Color.white)
    }
}

struct ReviewFooterView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewFooterView( showPopup: .constant(false), tabRight: {})
    }
}
