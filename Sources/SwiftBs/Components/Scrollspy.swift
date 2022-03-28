//
//  Scrollspy.swift
//  
//
//  Created by Brad Gourley on 3/19/22.
//

import SwiftHtml

public class Scrollspy: Component {
    
    /// @NOTE: Default <div style='position: relative'>
    public convenience init(onContainerId id: String,
                            offset pixelsFromTop: Int = 10,
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
        
        self.init(containerId: id, offset: pixelsFromTop, div)
    }

    public init(containerId id: String, offset pixelsFromTop: Int = 10, _ div: Div) {
        _ = div
            .dataBsSpy(.scroll)
            .dataBsTarget(id)
            .dataBsOffset(pixelsFromTop)
            .tabindex(0)
        
        super.init(div)
    }
}
