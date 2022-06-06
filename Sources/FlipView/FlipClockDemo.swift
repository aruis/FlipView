//
//  SwiftUIView.swift
//  
//  一个展示Flip效果的时钟，并不建议你直接使用，而是用来参考里面的代码，使其与您的项目融合
//  Created by Liu Rui on 2022/5/25.
//

import SwiftUI

struct FlipClockDemo: View {
    
    public var body: some View {
        
        VStack{
            
                TimelineView(.periodic(from: .now, by: 1)) { context in
                    let arr = Array( context.date.format("HHmmss")).map{String($0)}
                    
                    ZStack{
                        HStack{
                            ForEach(0...5, id: \.self) {i in
                                FlipView(text : .constant( arr[i]), flipCardColor:.gray, gap: 3)
                                    .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
                            }                            
                        }
                        
                    }
                    .padding(40)
                    
                }
                
            
        }
        .background(.black)
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
