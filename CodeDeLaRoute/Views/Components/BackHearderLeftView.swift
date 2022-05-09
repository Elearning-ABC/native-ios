//
//  BackHearderLeftView.swift
//  CodeDeLaRoute
//
//  Created by Nhung Nguyen on 21/04/2022.
//

import SwiftUI

struct BackHearderLeftView: View {
    var title: String
    var color : Color = Color.black
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    var body: some View {
        HStack {
            Image(systemName: "arrow.left")
                .foregroundColor(.black)
                .font(.system(size: 20.0))
                
            Text(title)
                .font(.system(size: 24, weight: .medium))
                .foregroundColor(color)
            
        }
        .onTapGesture {
            self.mode.wrappedValue.dismiss()
        }
        
    }
}

struct BackHearderLeftView_Previews: PreviewProvider {
    static var previews: some View {
        BackHearderLeftView(title: "title")
    }
}

