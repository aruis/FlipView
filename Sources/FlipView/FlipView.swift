//
//  SwiftUIView.swift
//
//  一个数字即为一个Flip，但其实它由上下两部分组成，上下各使用两个 HalfView。
//  Created by Liu Rui on 2022/5/25.
//

import SwiftUI

public struct FlipView: View {
    
    
    @State private var aniTop = true
    @State private var aniBottom = true
    @State private var aniShadow = true
    
    @State private var oldText:String = "0"
    
    @Binding var text:String
    
    
    @State var halfSize:CGFloat
    @State var flipCardColor:Color = .blue
    
    var aniTime:CGFloat
    
    var gap:CGFloat
    
    
    public init(text:Binding<String>,halfSize:CGFloat = CGFloat(60),flipCardColor:Color = .blue, aniTime:CGFloat = 0.2,gap:CGFloat = 4) {
        self._text = text
        self.halfSize = halfSize
        self.flipCardColor = flipCardColor
        self.aniTime = aniTime
        self.gap = gap
    }
    
        
    public var body: some View {
        
        
        
            
            VStack(spacing:gap){
                ZStack{
                    HalfView(text: $text,type: .top,size:halfSize,bgColor: flipCardColor)
                    HalfView(text:$oldText,type: .top,size:halfSize,bgColor: flipCardColor)
                        .overlay{
                            Color.black
                                .opacity(aniTop ? 0.35 : 0)
                        }
                        .rotation3DEffect(.degrees(aniTop ? -90 : 0), axis: (1,0,0), anchor: .bottom, perspective: 0.35)
                    
                }
                
                ZStack{
                    HalfView(text:$oldText,type: .bottom,size:halfSize,bgColor: flipCardColor)
                        .overlay{
                            Color.black
                                .opacity(aniShadow ? 0.35 : 0)
                                .clipShape(Shadow(depth: 10))
                                .offset( x: aniShadow ? -10 : 0 ,y: aniShadow ? 0 : -30)
                                .clipped()
                        }
                    
                    HalfView(text:$text,type: .bottom,size:halfSize,bgColor: flipCardColor)
                        .overlay{
                            Color.black
                                .opacity(aniBottom ? 0 : 0.15)
                        }
                        .rotation3DEffect(.degrees(aniBottom ? 0 : 90), axis: (1,0,0), anchor: .top, perspective: 0.35)
                    
                }
            }.onChange(of: text, perform: { _ in
                trigger()
            })
            
        
        
    }
    
    func trigger(){
        oldText = text
        
        
        aniTop =  false
        aniBottom = false
        aniShadow = false
        
        withAnimation(.easeIn(duration: aniTime)){
            aniTop.toggle()
        }
        
        withAnimation(.easeInOut(duration: aniTime).delay(aniTime*0.6)){
            aniShadow.toggle()
        }
        
        withAnimation(.easeOut(duration: aniTime).delay(aniTime)){
            aniBottom.toggle()
        }
        
        
    }
}

struct FlipView_Previews: PreviewProvider {
    static var previews: some View {
        TimelineView(.periodic(from: .now, by: 3)) { context in
            let arr = Array( context.date.format("HHmmss")).map{String($0)}
            
            FlipView(text:.constant(arr[5]) , halfSize:CGFloat(200), aniTime: 1, gap: 4)
            
        }

        
        
            
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
