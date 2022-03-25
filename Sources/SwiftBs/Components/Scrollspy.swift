//
//  Scrollspy.swift
//  
//
//  Created by Brad Gourley on 3/19/22.
//

import SwiftHtml

public class Scrollspy: Component {
    
    public static func link(scrollSpyItemId id: String, a: () -> A) -> A {
        let a = a()
        _ = a.href("#\(id)")
        return a
    }
    
    public convenience init(navId: String,
                            offset: Int = 0,
                            @TagBuilder contentsWithIds: () -> [Tag]) {
        let div = Div {
            contentsWithIds()
        }
        self.init(navId: navId, offset: offset, div)
    }
    
    public init(navId: String, offset: Int = 0, _ div: Div) {
        _ = div
            .dataBsSpy(.scroll)
            .dataBsTarget(navId)
            .dataBsOffset(offset)
            .tabindex(0)
        
        super.init(div)
    }
}
