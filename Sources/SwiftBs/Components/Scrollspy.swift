//
//  Scrollspy.swift
//  
//
//  Created by Brad Gourley on 3/19/22.
//

import SwiftHtml

public class Scrollspy: Component {
    
    /// @NOTE: Default <div style='position: relative'>
    /// offset: Pixels to offset from top when calculating position of scroll
    public convenience init(onContainerId id: String,
                            offset: Int = 10,
                            maxHeight: String? = nil,
                            isScrollOverflow: Bool = true,
                            @TagBuilder contentsWithIds: () -> [Tag]) {
        let div = Div {
            contentsWithIds()
        }.style(set: .position("relative"))
        
        if let maxHeight = maxHeight {
            div.style(set: .maxHeight(maxHeight))
        }
        if isScrollOverflow {
            div.style(set: .overflow("scroll"))
        }
        
        self.init(containerId: id, offset: offset, div)
    }

    public init(containerId id: String, offset: Int = 10, _ div: Div) {
        _ = div
            .dataBsSpy(.scroll)
            .dataBsTarget(id)
            .dataBsOffset(offset)
            .tabindex(0)
        
        super.init(div)
    }
}
