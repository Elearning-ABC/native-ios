//
//  AnswerView.swift
//  CodeDeLaRoute
//
//  Created by Nhung Nguyen on 27/04/2022.
//

import SwiftUI

struct AnswerView: View {
    var answer: String
    var body: some View {
        HStack(alignment: .center) {
            Text(answer)
                .font(.system(size: 16))
            Spacer()
            Image(systemName: "minus")
                .foregroundColor(.gray2)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
    }
}

struct AnswerView_Previews: PreviewProvider {
    static var previews: some View {
        AnswerView(answer: "AAAAAAAAAAA")
    }
}
