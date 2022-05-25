//
//  SwiftUIView.swift
//
//
//  Created by Liu Rui on 2022/5/25.
//

import SwiftUI

struct FlipView: View {
    
    @State var aniTop = true
    @State var aniBottom = true
    
    @State var oldText:String = "0"
    @State var newText:String = "0"
    
    @State var i = 0
    
    @State var halfSize = CGFloat(100)
    @State var flipCardColor:Color = .blue
    
    var aniTime = 0.2
    
    var body: some View {
        VStack{
            
                ZStack{
                    
                    VStack(spacing:0){
                        ZStack{
                            HalfView(text: $newText,type: .top,size:halfSize,bgColor: flipCardColor)                            
                            HalfView(text:$oldText,type: .top,size:halfSize,bgColor: flipCardColor)
                                .rotation3DEffect(.degrees(aniTop ? -90 : 0), axis: (1,0,0), anchor: .bottom, perspective: 0.35)

                        }
                        
                        ZStack{
                            HalfView(text:$oldText,type: .bottom,size:halfSize,bgColor: flipCardColor)
                                .overlay{
                                    Color.black
                                        .opacity(aniBottom ? 0.85 : 0)
                                        .clipShape(Shadow(depth: 10))
                                        .offset( x: aniBottom ? -10 : 0 ,y: aniBottom ? 0 : -10)//
                                        .clipped()
                                }
                            
                            HalfView(text:$newText,type: .bottom,size:halfSize,bgColor: flipCardColor)
                                .rotation3DEffect(.degrees(aniBottom ? 0 : 90), axis: (1,0,0), anchor: .top, perspective: 0.35)
                            
                        }
                        
                        
                    }
                    
                    
                    Color.black.frame(height:3)
                }

            
            
            
            Button("test"){
                i += 1
                setText(value: String(i))
            }
            
            Text("\(String(aniTop))")
            Text("\(String(aniBottom))")
            Text("\(String(oldText))")
            Text("\(String(newText))")
            
        }
        
        
    }
    
    func setText(value : String){
        oldText = newText
        
        
        aniTop =  false
        aniBottom = false
        
        withAnimation(.easeIn(duration: aniTime)){
            aniTop.toggle()
            newText = value
            
        }
        withAnimation(.easeOut(duration: aniTime).delay(aniTime)){
            aniBottom.toggle()
        }
        
        
    }
}

struct FlipView_Previews: PreviewProvider {
    static var previews: some View {
        FlipView(halfSize:CGFloat(200))
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
