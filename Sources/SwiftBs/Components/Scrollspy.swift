//
//  Scrollspy.swift
//  
//
//  Created by Brad Gourley on 3/19/22.
//

import SwiftHtml

public class Scrollspy: Component {
    
    public convenience init(navId: String,
                            offset: Int = 0,
                            @TagBuilder contentsWithIds: () -> [Tag]) {
        let div = Div {
            contentsWithIds()
        }
            .style(set: .position("relative"))
        
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
