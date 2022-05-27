//
//  PopupView.swift
//  CodeDeLaRoute
//
//  Created by Nhung Nguyen on 26/05/2022.
//

import SwiftUI

struct PopupView<Content:View>: View {
    @Binding var showPopup: Bool
    let viewBuilder: () -> Content
    var body: some View {
        VStack {
            Image("SwipeHint")
                .onTapGesture {
                    showPopup.toggle()
                }
            VStack{
                viewBuilder()
            }
            .cornerRadius(25,corners: [.topLeft, .topRight])
        }
    }
}

struct PopupView_Previews: PreviewProvider {
    static var previews: some View {
        PopupView(showPopup: .constant(false)){
            VStack {
                VStack{
                    Text("Report mistake")
                        .font(.title2)
                        .foregroundColor(.blue1)
                        .padding()
                    Spacer()
                }
                .frame(width: Screen.width, height: Screen.height/2)
                .background(Color.blue1)
                .cornerRadius(25,corners: [.topLeft, .topRight])
            }
        }
    }
}
