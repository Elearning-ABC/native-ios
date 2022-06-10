//
//  ReviewQuestionView.swift
//  CodeDeLaRoute
//
//  Created by Nhung Nguyen on 09/06/2022.
//

import SwiftUI

struct ReviewQuestionView: View {
    @EnvironmentObject var viewModel: ReviewViewModel
    @State var showReport: Bool = false
    var title: String
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    func update(){
        viewModel.upDateListQuestion(mode: mode)
    }
    var body: some View {
        
        let correctWidth = Screen.width*viewModel.progressBar
        let unfinishedWidth = Screen.width - correctWidth
        VStack {
            VStack {
                HStack {
                    BackHearderLeftView(title: "\(title) \(viewModel.correctNumber)/\(viewModel.listQuestionProgress.count)")
                    Spacer()
                    
                    Button{
                        
                    }label: {
                        Text("aA")
                            .foregroundColor(.black)
                            .font(.system(size: 20))
                    }
                    Image("Book")
                        .renderingMode(.template)
                        .foregroundColor(.black)
                }
                .padding(.trailing, 24.0)
                .padding(.leading)
                
                HStack {
                    HStack{
                        Spacer()
                    }
                    .frame(width: correctWidth, height: 4)
                    .background(Color.green)

                    HStack{
                      Spacer()
                    }
                    .frame(width: unfinishedWidth, height: 4)
                    .background(Color.blue3)
                }.padding(.bottom)
                    .padding(.top, 8.0)
                
            }
            .padding(.top, Screen.statusBarHeight)
            
            VStack{
                AnswerQuestionView(questionProgressApp: viewModel.listQuestionProgress[0])
                
            }
            .padding(.horizontal)
       
            ReviewFooterView(showPopup: $showReport, tabRight: update)
        }
        .background(BackGroundView())
        .ignoresSafeArea()
        
    }
}

struct ReviewQuestionView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewQuestionView( title: "")
    }
}
