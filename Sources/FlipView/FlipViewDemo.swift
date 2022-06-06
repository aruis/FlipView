//
//  SwiftUIView.swift
//  
//  用来展示一个FlipVIew是如何工作的
//  Created by Liu Rui on 2022/5/26.
//

import SwiftUI

struct FlipViewDemo: View {
    
    
    
    var body: some View {
        VStack{
            Text("hello")
                .foregroundColor(.textColor)
            Color.separator.frame(width:100, height:2)
        }
        .background(.background)
    }
}

struct FlipViewDemo_Previews: PreviewProvider {
    static var previews: some View {
        FlipViewDemo()
    }
}

extension Color {
    static  var background = Color("background")
    static  var separator = Color("separator")
    static  var textColor = Color("text_color")
}
