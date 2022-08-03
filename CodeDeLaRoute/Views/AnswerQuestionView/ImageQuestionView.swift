//
//  ImageQuestionView.swift
//  CodeDeLaRoute
//
//  Created by HongTuan on 02/08/2022.
//

import SwiftUI

struct ImageQuestionView: View {
    @EnvironmentObject var viewModel: ViewModel
    var imageName: String
    @State var isShow: Bool = false
    var body: some View{
        let imageId = imageName
        VStack(spacing: 0){
            Image(imageName.replace(target: ".png", withString: ""))
                .resizable()
                .scaledToFit()
                .matchedGeometryEffect(id: imageId, in: viewModel.namespace)
                .frame(width:80)
                .clipped()
            Image(systemName: "plus.magnifyingglass")
                .foregroundColor(isShow ? Color.white.opacity(0.0) : Color.black)
                .font(.system(size: 16))
        }
        .onTapGesture{
            viewModel.imageString = imageName.replace(target: ".png", withString: "")
            viewModel.imageId = imageId
            withAnimation{
                isShow = true
                viewModel.showImage.toggle()
            }
        }
        .onChange(of: viewModel.showImage, perform: {showImage in
            if !showImage{
                withAnimation{
                    isShow = false
                }
            }
        })
    }
}

struct ImageQuestionView_Previews: PreviewProvider {
    static var previews: some View {
        ImageQuestionView(imageName: "7.png")
    }
}
