//
//  HtmlTextView.swift
//  CodeDeLaRoute
//
//  Created by HongTuan on 01/08/2022.
//

import SwiftUI

struct HtmlTextView: View {
    var htmlString: String
    @State var text : String?
    @State var imageInTexts = [ImageInText]()
    
    func htmlToString(htmlString: String){
        text = htmlString.htmlToString
    }
    
    func onAppear(){
        text = nil
        htmlToString(htmlString: htmlString)
    }
    
    var body: some View {
        VStack{
            if let text = text {
                TextWithImageView(text: text)
            }
        }
        .onAppear(perform: onAppear)
        
    }
}
struct HtmlTextView_Previews: PreviewProvider {
    static var previews: some View {
        HtmlTextView(htmlString: "<p>hello $1435_w9_h37.png$ $4000 $4000 hello<p>")
    }
}

