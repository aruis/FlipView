//
//  SwiftUIView.swift
//  
//
//  Created by Liu Rui on 2022/5/25.
//

import SwiftUI

struct FlipClock: View {
    
    var body: some View {
        
        VStack{
            
                TimelineView(.periodic(from: .now, by: 1)) { context in
                    let arr = Array( context.date.format("HHmmss")).map{String($0)}
                    
                    ZStack{
                        HStack{
                            ForEach(0...5, id: \.self) {i in
                                FlipView(text : .constant( arr[i]))
                                    .cornerRadius(10)
                            }                            
                        }
                        Color.black.frame(height:2)
                    }
                    .padding(.vertical,40)
                    
                }
                
            
        }
        .background(.black)
    }
}



struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        FlipClock()
    }
}

extension Date {
    func format(_ format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
    
}
