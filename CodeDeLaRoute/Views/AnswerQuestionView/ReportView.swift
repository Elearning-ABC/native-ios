//
//  ReportView.swift
//  CodeDeLaRoute
//
//  Created by HongTuan on 21/07/2022.
//

import SwiftUI

struct ReportView: View {
    var body: some View {
        VStack{
            Text("Report mistake")
                .font(.title2)
                .foregroundColor(.blue1)
                .padding()
            Spacer()
        }
        .frame(width: Screen.width, height: Screen.height/2)
        .background(BackGroundView())
        .cornerRadius(25,corners: [.topLeft, .topRight])
    }
}

struct ReportView_Previews: PreviewProvider {
    static var previews: some View {
        ReportView()
    }
}
