//
//  SwiftUIView.swift
//  
//  用来展示一个FlipVIew是如何工作的
//  Created by Liu Rui on 2022/5/26.
//

import SwiftUI

struct FlipViewDemo: View {
    
    @State var i = 0
    
    var body: some View {
        VStack{
            FlipView(text: .constant(String(i)),halfSize: 100)
                .cornerRadius(10)
            Text("\(i)")
            Button("test"){
                i += 1
            }
        }
    }
}

struct FlipViewDemo_Previews: PreviewProvider {
    static var previews: some View {
        FlipViewDemo()
    }
}
