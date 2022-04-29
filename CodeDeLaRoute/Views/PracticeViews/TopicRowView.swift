//
//  TopicRowView.swift
//  CodeDeLaRoute
//
//  Created by Nhung Nguyen on 19/04/2022.
//

import SwiftUI


@available(iOS 15.0, *)
struct TopicRowView: View {
    @EnvironmentObject var viewModel : PraticeViewModel
    @State var isActive: Bool = false
    var name: String
    var urlIcon: String
    var id: String
    var total: Int
    
    
    var body: some View {
        NavigationLink(destination: TopicChildView(title: name, total: total)
                        .environmentObject(viewModel)
                        .navigationBarHidden(true)
                       ,
                       isActive: $isActive
        ){
            VStack {
                VStack {
                    HStack(alignment: .top) {
                        Text(name)
                            .foregroundColor(.blue1)
                            .font(.system(size: 24, weight: .semibold))
                        Spacer()
                        VStack {
                            SVGKFastImageViewSUI(url: .constant(URL(string: urlIcon)!), size: .constant(CGSize(width: 16,height: 16)), tintColor:  .constant(Color.white))
                                .frame(width: 16, height: 16)
                        }
                        .frame(width: 24, height: 24)
                        .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray, lineWidth: 2)
                            )
                        .background(
                            LinearGradient(gradient: Gradient(colors: [ Color("#002395")!,Color("#969BFF")!]), startPoint: .bottomLeading, endPoint: .topTrailing)
                            )
                        .cornerRadius(8)
                    }
                }
                
                DividingLineView(color: Color.blue3!)
                    .padding(.vertical, 8.0)
                
                
                HStack {
                    ProgressView(value: 5, total: 10)
                        .accentColor(Color.blue1)
                        .background(Color.blue3)
                          .frame(height: 8.0)
                          .scaleEffect(x: 1, y: 2, anchor: .center)
                      .clipShape(RoundedRectangle(cornerRadius: 4))
                    Text("50%")
                        .foregroundColor(.blue1)
                        .font(.system(size: 14))
                }
                
            }
            .padding()
            .background(Color.white)
            .cornerRadius(8)
            .onTapGesture{
                viewModel.getListChildTopics(id: id)
                isActive = true
            }
        }
    }
}

@available(iOS 15.0, *)
struct TopicRowView_Previews: PreviewProvider {
    static var previews: some View {
        TopicRowView(name: "Topic", urlIcon: "https://storage.googleapis.com/micro-enigma-235001.appspot.com/g1/icons/file-1620185333946-icon2.svg", id: "", total: 10)
    }
}

struct RoundedRectProgressViewStyle: ProgressViewStyle {
    func makeBody(configuration: Configuration) -> some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 4)
                .frame(height: 8)
                .foregroundColor(.blue3)
                            
            RoundedRectangle(cornerRadius: 4)
                .frame(width: CGFloat(configuration.fractionCompleted ?? 0) * 250, height: 8)
                .foregroundColor(.blue1)
        }
    }
}
