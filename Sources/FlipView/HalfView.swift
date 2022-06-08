//
//  SwiftUIView.swift
//  
//  Flip中的半个，构成一个完整Flip，需要上下各一个 HalfView 进行拼接，但是如果要展示动画，则需要4个HalfView进行配合。
//  Created by Liu Rui on 2022/5/25.
//

import SwiftUI

struct HalfView: View {
    @Binding var text:String
    
    var type:HalfType
    
    enum HalfType{
        case top
        case bottom
    }
    
    var body: some View {
        GeometryReader{ geometry in
            let size = geometry.size
            Text(text)
                .font(.system(size:size.width * 1.5).monospacedDigit())
                .position(x: size.width/2, y: type == .top ? size.height : 0)
        }
        
        .clipped()
//        .background(.brown)
        //            .padding(type == .top ? .bottom : .top,-size/2)
        //            .frame(width: size * 0.6,height: size/2)
        //            .clipped()
        //            .background(bgColor)
        
        
        //        .clipShape(RoundedRectangle(cornerRadius: 10,style: .continuous))
    }
    
    
}

struct HalfView_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            HalfView( text: .constant("5") ,type: .top)
                .frame(width: 100, height: 100)
                .background(.black)
                .foregroundColor(.white)
            HalfView( text: .constant("5") ,type: .bottom)
                .frame(width: 100, height: 100)
                .background(.black)
                .foregroundColor(.white)
        }
        

    }
}
