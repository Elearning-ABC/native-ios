//
//  TextWithImageView.swift
//  CodeDeLaRoute
//
//  Created by HongTuan on 01/08/2022.
//

import SwiftUI

struct TextWithImageView: View {
    var text: String
    @State var imageInTexts = [ImageInText]()
    
    func onAppear(){
        textToTextWithImage(text: text)
    }
    
    func textToTextWithImage(text: String){
        imageInTexts.removeAll()
        var currentIndex: String.Index = text.startIndex
        var isEnd = false
        for index in text.indices{
            if text[index] == "$" && isEnd == false{
                currentIndex = index
                isEnd = true
            }else {
                if text[index] == " "{
                    isEnd = false
                }
                if index >= "png$".endIndex{
                    if text[text.index(index, offsetBy: -3)...index] == "png$" && isEnd{
                        
                        let imageInText = ImageInText(imageName: String(text[text.index(after: currentIndex)..<index]).replace(target: ".png", withString: ""), startIndex: currentIndex, endIndex: text.index(after: index))
                        imageInTexts.append(imageInText)

                        currentIndex = index
                        isEnd = false
                    }
                }
            }
        }
    }
    
    var body: some View {
        VStack{
            CasesImageInText(text: text, imageInTexts: imageInTexts)
        }
        .onAppear(perform: onAppear)
//        .onChange(of: text, perform: {text in
//            textToTextWithImage(text: text)
//        })
    }
}

struct TextWithImageView_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            TextWithImageView(text: "hello $4000 $400 hello $1435_w9_h37.png$ hello $1435_w9_h37.png$ hello")
        }
    }
}

struct ImageInText: Identifiable{
    var id: String = UUID().uuidString
    var imageName: String
    var startIndex: String.Index
    var endIndex: String.Index
}


struct CasesImageInText: View{
    var text: String
    var imageInTexts : [ImageInText]
    
    var body: some View{
        VStack{
            switch imageInTexts.count{
            case 1:
                Text(String(text[..<imageInTexts[0].startIndex]))
                + Text(Image(imageInTexts[0].imageName))
                + Text(String(text[imageInTexts[0].endIndex...]))
            case 2:
                Text(String(text[..<imageInTexts[0].startIndex]))
                
                + Text(Image(imageInTexts[0].imageName))
                
                + Text(String(text[imageInTexts[0].endIndex...text.index(before: imageInTexts[1].startIndex)]))
                
                + Text(Image(imageInTexts[1].imageName))
                
                +   Text(String(text[imageInTexts[1].endIndex...]))
                
            case 3:
                Text(String(text[..<imageInTexts[0].startIndex]))
                
                + Text(Image(imageInTexts[0].imageName))
                
                + Text(String(text[imageInTexts[0].endIndex...text.index(before: imageInTexts[1].startIndex)]))
                
                + Text(Image(imageInTexts[1].imageName))
                + Text(String(text[imageInTexts[1].endIndex...text.index(before: imageInTexts[2].startIndex)]))
                
                + Text(Image(imageInTexts[2].imageName))
                
                +   Text(String(text[imageInTexts[2].endIndex...]))
            default:
                Text(text)
            }
        }
    }
}
