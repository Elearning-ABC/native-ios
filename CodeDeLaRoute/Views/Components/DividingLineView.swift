//
//  DividingLineView.swift
//  CodeDeLaRoute
//
//  Created by Nhung Nguyen on 21/04/2022.
//

import SwiftUI

struct DividingLineView: View {
    var color: Color = Color.gray1!
    var body: some View {
        HStack{
            Spacer()
        }
        .frame(height: 1)
        .background(color)
    }
}

struct DividingLineView_Previews: PreviewProvider {
    static var previews: some View {
        DividingLineView(color: Color.gray)
    }
}
