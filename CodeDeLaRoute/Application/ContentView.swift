//
//  ContentView.swift
//  CodeDeLaRoute
//
//  Created by Nhung Nguyen on 13/04/2022.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel : ViewModel
    var body: some View {
        if viewModel.settingApp == nil {
            StartView()
        }else{
            VStack{
                
                NavigationView{
                    MainView()
                        .navigationBarHidden(true)
                }
                .showChangeFontSizeView(show: $viewModel.showChangeFontSize, fontSize: viewModel.settingApp!.fontSize, onChangeFontSize: { size in  viewModel.onChangeFontSize(size: size)})
                .showImageView(show: $viewModel.showImage, image: viewModel.imageString, namespace: viewModel.namespace, id: viewModel.imageId)
                .popup(isShow: $viewModel.isShowReport, anyView: AnyView(ReportView(isShowReport: $viewModel.isShowReport)))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
