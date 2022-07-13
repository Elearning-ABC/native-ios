//
//  ReviewTopicRow.swift
//  CodeDeLaRoute
//
//  Created by HongTuan on 23/06/2022.
//

import SwiftUI

struct ReviewTopicRowView: View {
    var name: String
    var value: Double
    var total: Double
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack{
                Text(name)
                    .foregroundColor(.black)
                    .font(.system(size: 18, weight: .semibold))
                Spacer()
                Text("\(Int(100*value/total))%")
                    .foregroundColor(.gray)
                    .font(.system(size: 16))
            }
            ProgressView(value: value, total: total)
                .accentColor(Color.blue1)
                .background(Color.blue3)
                  .frame(height: 8.0)
                  .scaleEffect(x: 1, y: 2, anchor: .center)
              .clipShape(RoundedRectangle(cornerRadius: 4))
        }
        .padding()
        .background(Color.white)
        .cornerRadius(8)
    }
}

struct ReviewTopicRow_Previews: PreviewProvider {
    static var previews: some View {
        ReviewTopicRowView(name: "", value: 1, total: 1)
    }
}
