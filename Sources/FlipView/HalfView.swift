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
    var cornerRadius:CGFloat
    
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
        .cornerRadius(cornerRadius,corners: type == .top ? .topLeft : .bottomLeft)
        .cornerRadius(cornerRadius,corners: type == .top ? .topRight : .bottomRight)
//        .clipShape(RoundedRectangle(cornerRadius: 10,style: .continuous))
    }
    
    
}

struct HalfView_Previews: PreviewProvider {
    static var previews: some View {
        HalfView( text: .constant("0") ,type: .top,size:100,bgColor: .black,cornerRadius:10)
        HalfView( text: .constant("0") ,type: .bottom,size:100,bgColor: .black,cornerRadius:10)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
