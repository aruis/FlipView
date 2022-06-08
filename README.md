# FlipView

一个简单的翻页时钟效果：

![CleanShot-2022-05-31-11 02 57](https://user-images.githubusercontent.com/1785495/171084575-e2967ae2-d434-4359-abb1-ce92f044bad4.gif)

```swift
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
```

也可以把其中一个Flip单独拿出来，做自己想要的文字展示效果

![CleanShot-2022-05-31-11 05 19](https://user-images.githubusercontent.com/1785495/171084764-9b619223-e630-4622-b571-c0188d8a589e.gif)

```swift
import SwiftUI

struct FlipViewDemo: View {
    
    @State var i = 0
    
    
    var body: some View {
        VStack{
            FlipView( .constant(String(i)) ,flipColor: .constant(.brown))
                .frame(width: 100, height: 200)
                .foregroundColor(.white)
                .cornerRadius(10)
            
            Text("\(i)")
            Button("test"){
                i += 1
                
            }
        }
        .background(.background)
    }
}

struct FlipViewDemo_Previews: PreviewProvider {
    static var previews: some View {
        FlipViewDemo()
    }
}

```

