
import SwiftHtml

open class Scrollspy: Div {
    
    /// @NOTE: Default <div style='position: relative'>
    public init(onContainerId id: String,
                offset pixelsFromTop: Int = 10,
                maxHeight: String? = nil,
                isScrollOverflow: Bool = true,
                @TagBuilder contentWithIds: () -> Tag) {
        super.init([contentWithIds()])
        self
            .dataBsSpy(.scroll)
            .dataBsTarget(id)
            .dataBsOffset(pixelsFromTop)
            .tabindex(0)
            .style(set: .position("relative"))
            .style(set: .maxHeight(maxHeight), if: maxHeight != nil)
            .style(set: .overflow("scroll"), if: isScrollOverflow)
    }    
}
