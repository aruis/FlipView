//
//  SwiftUIView.swift
//
//  一个数字即为一个Flip，但其实它由上下两部分组成，上下各使用两个 HalfView。
//  Created by Liu Rui on 2022/5/25.
//

import SwiftUI

struct FlipView: View {
    @State var t = 0
    
    @State private var aniTop = true
    @State private var aniBottom = true
    @State private var aniShadow = true
    
    @State private var oldText:String = "0"
    
    @Binding var text:String
    
    
    @State var halfSize = CGFloat(60)
    @State var flipCardColor:Color = .blue
    
    var aniTime = 0.2
    var cornerRadius:CGFloat = 0
    
    var body: some View {
        
        
        ZStack{
            
            VStack(spacing:0){
                ZStack{
                    HalfView(text: $text,type: .top,size:halfSize,bgColor: flipCardColor , cornerRadius :cornerRadius)
                    HalfView(text:$oldText,type: .top,size:halfSize,bgColor: flipCardColor,cornerRadius:cornerRadius)
                        .rotation3DEffect(.degrees(aniTop ? -90 : 0), axis: (1,0,0), anchor: .bottom, perspective: 0.35)
                    
                }
                
                ZStack{
                    HalfView(text:$oldText,type: .bottom,size:halfSize,bgColor: flipCardColor,cornerRadius:cornerRadius)
                        .overlay{
                            Color.black
                                .opacity(aniShadow ? 0.85 : 0)
                                .clipShape(Shadow(depth: 10))
                                .offset( x: aniShadow ? -10 : 0 ,y: aniShadow ? 0 : -10)
                                .clipped()
                                .cornerRadius(cornerRadius,corners:  .bottomRight)
                                .cornerRadius(cornerRadius,corners:  .bottomLeft)
                        }
                    
                    HalfView(text:$text,type: .bottom,size:halfSize,bgColor: flipCardColor,cornerRadius:cornerRadius)
                        .rotation3DEffect(.degrees(aniBottom ? 0 : 90), axis: (1,0,0), anchor: .top, perspective: 0.35)
                    
                }
            }.onChange(of: text, perform: { _ in
                trigger()
            })
            
        }
        
    }
    
    func trigger(){
        oldText = text
        
        
        aniTop =  false
        aniBottom = false
        aniShadow = false
        
        withAnimation(.easeIn(duration: aniTime)){
            aniTop.toggle()
        }
        
        withAnimation(.easeIn(duration: aniTime).delay(aniTime*0.7)){
            aniShadow.toggle()
        }
        
        withAnimation(.easeOut(duration: aniTime).delay(aniTime)){
            aniBottom.toggle()
        }
        
        
    }
}

struct FlipView_Previews: PreviewProvider {
    static var previews: some View {
        FlipView(text:.constant("2") , halfSize:CGFloat(200))
            .cornerRadius(0)
    }
}

struct Shadow: Shape {
    
    var depth: CGFloat
    var flipped: Bool = false
    
    func path(in rect: CGRect) -> Path {
        Path { p in
            
            p.move(to: CGPoint(x: 0, y: 0))
            p.addLine(to: CGPoint(x: depth, y: rect.height))
            p.addLine(to: CGPoint(x: rect.width+depth, y:rect.height))
            p.addLine(to: CGPoint(x: rect.width+depth, y: 0))
            
            p.closeSubpath()
        }
    }
}

extension FlipView {
    
    mutating func cornerRadius(_ radius: CGFloat) -> some View {
        self.cornerRadius = radius
        return self
    }
}
