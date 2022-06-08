//
//  SwiftUIView.swift
//  
//  一个展示Flip效果的时钟，并不建议你直接使用，而是用来参考里面的代码，使其与您的项目融合
//  Created by Liu Rui on 2022/5/25.
//

import SwiftUI

struct FlipClockDemo: View {
    
    public var body: some View {
        
        GeometryReader{ geometry in
            let size = geometry.size
            let width = size.width / 8
            let height = width*2
            
                TimelineView(.periodic(from: .now, by: 1)) { context in
                    let arr = Array( context.date.format("HHmmss")).map{String($0)}
                    
                    ZStack{
                        HStack{
                            ForEach(0...5, id: \.self) {i in
                                FlipView(.constant( arr[i]), flipColor: .constant(.black), gap: 3)
                                    .frame(width: width, height: height)
                                    .foregroundColor(.white)
                                    .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
                            }                            
                        }
                        
                    }
                    .padding(40)
                    
                }
                .position(x: size.width/2, y: size.height/2)
                
            
        }
    }
}



struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        FlipClockDemo()
    }
}

extension Date {
    func format(_ format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
    
}
