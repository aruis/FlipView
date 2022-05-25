//
//  SwiftUIView.swift
//  
//
//  Created by Liu Rui on 2022/5/25.
//

import SwiftUI

struct HalfView: View {
    @Binding var text:String
    
    var type:HalfType
    var size:CGFloat
    var bgColor:Color = .black
    
    enum HalfType{
        case top
        case bottom
    }
    
    var body: some View {

        VStack{
            Text(text)
                .font(.system(size: size*0.88).monospacedDigit())
                .foregroundColor(.white)
                
        }
        .padding(type == .top ? .bottom : .top,-size/2)
        .frame(width: size * 0.6,height: size/2)
        .clipped()
        .background(bgColor)
    }
    
    
}

struct HalfView_Previews: PreviewProvider {
    static var previews: some View {
        HalfView( text: .constant("0") ,type: .top,size:100,bgColor: .black)


    }
}
